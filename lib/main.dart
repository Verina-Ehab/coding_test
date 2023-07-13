import 'package:coding_test/features/classes/presentation/bloc/get_classes/get_classes_bloc.dart';
import 'package:coding_test/features/overview/presentation/screens/overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/themes/light_theme.dart';
import 'features/classes/presentation/screens/classes_page.dart';
import 'features/community/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/community/presentation/bloc/get_posts/get_posts_bloc.dart';
import 'features/community/presentation/screens/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> myPages = const [
      OverviewPage(),
      ClassesPage(),
      PostsPage(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<GetPostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
        BlocProvider(create: (_) => di.sl<GetClassesBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: DefaultTabController(
            length: myPages.length,
            child: Scaffold(
              appBar: _buildAppbar(),
              body: TabBarView(children: myPages),
            )),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text('The Challenge'),
      bottom: const TabBar(tabs: [
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Classes",
        ),
        Tab(
          text: "Community",
        ),
      ]),
    );
  }
}
