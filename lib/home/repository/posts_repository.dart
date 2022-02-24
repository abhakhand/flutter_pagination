import 'dart:convert';

import 'package:flutter_pagination/home/models/post.dart';
import 'package:http/http.dart' as http;

class PostsRepository {
  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final response = await http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '20'},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;

      return body.map((dynamic json) {
        return Post.fromJson(json);
      }).toList();
    }

    throw Exception('Error fetching Posts!');
  }
}
