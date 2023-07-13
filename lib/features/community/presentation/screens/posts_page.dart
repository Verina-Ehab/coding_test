import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../bloc/get_posts/get_posts_bloc.dart';
import '../widgets/posts_list_widget.dart';
import 'post_add_update_page.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  // AppBar _buildAppbar() => AppBar(
  //       title: const Text('Posts'),
  //     );

  FloatingActionButton _buildFloatingActionButton(BuildContext context) =>
      FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(
                      isUpdatePost: false,
                    )));
      });

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<GetPostsBloc, GetPostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return const LoadingWidget();
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: PostListWidget(posts: state.posts));
            } else if (state is ErrorPostsState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: MessageDisplayWidget(message: state.message)
                  );
            }
            return const LoadingWidget();
          },
        ),
      );

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<GetPostsBloc>(context).add(RefreshPostsEvent());
  }
}
