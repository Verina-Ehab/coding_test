import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int? id; //may be null, because adding post won't need to send id
  final String title;
  final String body;

  const Post({this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}
