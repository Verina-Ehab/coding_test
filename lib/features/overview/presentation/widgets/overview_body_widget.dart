import 'package:flutter/material.dart';

import '../../../community/domain/entities/post_entity.dart';


class OverviewBodyWidget extends StatelessWidget {
  final List<Post> posts;
  const OverviewBodyWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(posts[index].title , style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(posts[index].body),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        
      ),
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}
