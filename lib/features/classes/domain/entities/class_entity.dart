import 'package:equatable/equatable.dart';

class Class extends Equatable {
  final int? id; 
  final String title;
  final String url;

  const Class({this.id, required this.title, required this.url});

  @override
  List<Object?> get props => [id, title, url];
}
