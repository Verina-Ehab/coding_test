import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/delete_dialog_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/snackbar_message.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../screens/posts_page.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      btnColor: Colors.redAccent,
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline,),
      // label: "Delete",
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(
                objectID: postId,
                ifYes: () {
                  BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
                    DeletePostEvent(postId: postId),
                  );
                },
              );
            },
          );
        });
  }
}
