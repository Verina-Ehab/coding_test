import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/class_entity.dart';


// implement failures first

abstract class ClassesRepository {
  Future<Either<Failure, List<Class>>> getAllClasses();
}
