import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../domain_repo/posts_repo.dart';
import '../entities/post_entity.dart';


class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
