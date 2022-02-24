import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.body,
  });

  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  @override
  String toString() => 'Post(id: $id, title: $title, body: $body)';

  @override
  List<Object> get props => [id, title, body];
}
