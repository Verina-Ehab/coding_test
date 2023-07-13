import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../../../community/presentation/bloc/get_posts/get_posts_bloc.dart';
import '../widgets/overview_body_widget.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<GetPostsBloc, GetPostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return const LoadingWidget();
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: OverviewBodyWidget(posts: state.posts));
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
