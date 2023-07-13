import 'package:flutter/material.dart';

import '../../domain/entities/class_entity.dart';

class ClassListWidget extends StatelessWidget {
  final List<Class> classes;
  const ClassListWidget({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: classes.length,
      gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Image.network(classes[index].url),
    );
  }
}
