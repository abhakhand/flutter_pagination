import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pagination/home/models/post.dart';
import 'package:flutter_pagination/home/repository/posts_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(this._postsRepository) : super(const PostsState()) {
    on<PostsFetched>(
      _onPostsFetched,
      transformer: throttleDroppable(),
    );
  }

  final PostsRepository _postsRepository;

  Future<void> _onPostsFetched(
    PostsFetched event,
    Emitter<PostsState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == PostsStatus.initial) {
        final posts = await _postsRepository.fetchPosts();

        return emit(
          state.copyWith(
            status: PostsStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }

      final posts = await _postsRepository.fetchPosts(state.posts.length);

      posts.isEmpty
          ? emit(
              state.copyWith(
                hasReachedMax: true,
              ),
            )
          : emit(
              state.copyWith(
                status: PostsStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(
        state.copyWith(
          status: PostsStatus.failure,
        ),
      );
    }
  }
}

const defaultThrottleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>([
  Duration duration = defaultThrottleDuration,
]) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
