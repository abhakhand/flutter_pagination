import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination/home/bloc/posts_bloc.dart';
import 'package:flutter_pagination/home/repository/posts_repository.dart';
import 'package:flutter_pagination/home/views/widgets/posts_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RepositoryProvider(
        create: (context) => PostsRepository(),
        child: BlocProvider(
          create: (context) => PostsBloc(
            context.read<PostsRepository>(),
          )..add(PostsFetched()),
          child: const PostsList(),
        ),
      ),
    );
  }
}
