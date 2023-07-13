
import '../../domain/entities/class_entity.dart';

class ClassModel extends Class{
  const ClassModel({super.id, required super.title, required super.url});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(id: json['id'], title: json['title'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'url': url};
  }

} 