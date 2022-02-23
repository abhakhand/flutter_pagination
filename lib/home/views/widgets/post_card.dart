import 'package:flutter/material.dart';
import 'package:flutter_pagination/home/models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 2,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Text(
                '${post.id}',
                style: textTheme.caption,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        title: Text(post.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            post.body,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
