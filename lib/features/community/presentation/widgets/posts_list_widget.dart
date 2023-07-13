import 'package:coding_test/features/community/presentation/widgets/post_details_widget/delete_post_btn_widget.dart';
import 'package:coding_test/features/community/presentation/widgets/post_details_widget/update_post_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/post_entity.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) =>
      //  ListTile(
        // leading: 
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(child: Text(posts[index].id.toString())),
                  CircleAvatar(
                    child: UpdatePostBtnWidget(
                      post: posts[index],
                    ),
                  ),
                  CircleAvatar(
                      child: DeletePostBtnWidget(postId: posts[index].id!)),
                ],
              ),
            ),
            SizedBox(
              width: size.width*0.8,
              child: Column(
                children: [
                  Text(posts[index].title),
                  Text(posts[index].body),
                ],
              ),
            )
          ],
        ),
        // title: Text(posts[index].title),
        // subtitle: Text(posts[index].body),
        // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        // onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => PostDetailPage(
          //               post: posts[index],
          //             )));
        // },
      // ),
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}
