import 'package:flutter/material.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int objectID;              //postId
  final void Function()? ifYes;
  const DeleteDialogWidget({
    Key? key,
    required this.objectID,
    this.ifYes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: ifYes,
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
