import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display_widget.dart';
import '../bloc/get_classes/get_classes_bloc.dart';
import '../widgets/classes_list_widget.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<GetClassesBloc, GetClassesState>(
          builder: (context, state) {
            if (state is LoadingClassesState) {
              return const LoadingWidget();
            } else if (state is LoadedClassesState) {
              return RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: ClassListWidget(classes: state.classes));
            } else if (state is ErrorClassesState) {
              return MessageDisplayWidget(message: state.message);
            }
            return const LoadingWidget();
          },
        ),
      );

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<GetClassesBloc>(context).add(RefreshClassesEvent());
  }
}
