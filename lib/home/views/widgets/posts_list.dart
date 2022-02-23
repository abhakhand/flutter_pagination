import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination/home/bloc/posts_bloc.dart';
import 'package:flutter_pagination/home/views/widgets/loader.dart';
import 'package:flutter_pagination/home/views/widgets/post_card.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  late ScrollController _scrollController;

  bool _isBottom([
    double scrollOffsetThreshold = 0.7,
  ]) {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * scrollOffsetThreshold);
  }

  void _onScroll() {
    if (_isBottom()) context.read<PostsBloc>().add(PostsFetched());
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state.status == PostsStatus.failure) {
          return const Center(
            child: Text('Failed to fetch Posts!'),
          );
        }

        if (state.status == PostsStatus.success) {
          if (state.posts.isEmpty) {
            return const Center(
              child: Text('No Posts!'),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? const Loader()
                  : PostCard(post: state.posts[index]);
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
