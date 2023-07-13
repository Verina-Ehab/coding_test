import 'features/classes/data/data_repo/classes_repo_imp.dart';
import 'features/classes/data/data_source/class_local_datasource.dart';
import 'features/classes/data/data_source/class_remote_datasource.dart';
import 'features/classes/domain/domain_repo/classes_repo.dart';
import 'features/classes/domain/use_cases/get_all_classes.dart';
import 'features/classes/presentation/bloc/get_classes/get_classes_bloc.dart';
import 'features/community/data/data_repo/posts_repo_imp.dart';

import 'core/networking/network_info.dart';
import 'features/community/data/data_source/post_local_datasource.dart';
import 'features/community/data/data_source/post_remote_datasource.dart';
import 'features/community/domain/domain_repo/posts_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/community/domain/use_cases/add_post.dart';
import 'features/community/domain/use_cases/delete_post.dart';
import 'features/community/domain/use_cases/get_all_posts.dart';
import 'features/community/domain/use_cases/update_post.dart';
import 'features/community/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/community/presentation/bloc/get_posts/get_posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => GetPostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

  sl.registerFactory(() => GetClassesBloc(getAllClasses: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

  sl.registerLazySingleton(() => GetAllClassesUsecase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImp(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<ClassesRepository>(() => ClassesRepositoryImp(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<ClassRemoteDataSource>(
      () => ClassRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<ClassLocalDataSource>(
      () => ClassLocalDataSourceImp(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
