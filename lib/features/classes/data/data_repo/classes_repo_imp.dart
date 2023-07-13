import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/network_info.dart';
import '../../domain/domain_repo/classes_repo.dart';
import '../../domain/entities/class_entity.dart';
import '../data_source/class_local_datasource.dart';
import '../data_source/class_remote_datasource.dart';

// implement local and remote dataSource first
// then implement network checker,
// then return here and continue implementing functions

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class ClassesRepositoryImp extends ClassesRepository {
  final ClassRemoteDataSource remoteDataSource;
  final ClassLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ClassesRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Class>>> getAllClasses() async {
    // Remote Data
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllClasses();
        localDataSource.cacheClasses(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    // Local Data
    else {
      try {
        final localPosts = await localDataSource.getCachedClasses();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
