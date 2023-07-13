import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/domain_repo/posts_repo.dart';
import '../../domain/entities/post_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/network_info.dart';
import '../data_source/post_local_datasource.dart';
import '../data_source/post_remote_datasource.dart';
import '../model/post_model.dart';

// implement local and remote dataSource first
// then implement network checker,
// then return here and continue implementing functions


typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImp extends PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    // Remote Data
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    // Local Data
    else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    final PostModel postModel = PostModel(title: post.title, body: post.body);

    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async{
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async { //DeleteOrUpdateOrAddPost == Future<Unit> Function()
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}
