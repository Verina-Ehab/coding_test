import 'package:dartz/dartz.dart';
import '../domain_repo/classes_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/class_entity.dart';

class GetAllClassesUsecase {
  ClassesRepository repository;
  GetAllClassesUsecase(
    this.repository,
  );


  // we named this function "call" to make this class callable
      // callable mean that we can call this fn using its class name
      // GetAllPostsUsecase getAllPostsUsecase= GetAllPostsUsecase();
      // print(getAllPostsUsecase()) == print(getAllPostsUsecase.call())

  Future<Either<Failure, List<Class>>> call() async{
    return await repository.getAllClasses();
  }

}
