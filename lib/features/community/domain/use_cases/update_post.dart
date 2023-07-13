import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../domain_repo/posts_repo.dart';
import '../entities/post_entity.dart';

class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
