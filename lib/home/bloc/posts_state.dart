part of 'posts_bloc.dart';

enum PostsStatus { initial, success, failure }

class PostsState extends Equatable {
  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.hasReachedMax = false,
  });

  final PostsStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      '''
PostsState(status: $status, posts: $posts, hasReachedMax: $hasReachedMax)''';

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
