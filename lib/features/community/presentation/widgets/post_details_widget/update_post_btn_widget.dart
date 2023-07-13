import 'package:flutter/material.dart';

import '../../../../../core/widgets/button_widget.dart';
import '../../../domain/entities/post_entity.dart';
import '../../screens/post_add_update_page.dart';


class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostAddUpdatePage(
                          isUpdatePost: true,
                          post: post,
                        ),
                      ));
                },
                icon: const Icon(Icons.edit),
                // label: "Edite",
              );
  }
}
