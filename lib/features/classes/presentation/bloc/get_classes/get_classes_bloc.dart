// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:coding_test/features/classes/domain/entities/class_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/use_cases/get_all_classes.dart';

part 'get_classes_event.dart';
part 'get_classes_state.dart';

class GetClassesBloc extends Bloc<GetClassesEvent, GetClassesState> {
  final GetAllClassesUsecase getAllClasses;

  GetClassesBloc({required this.getAllClasses}) : super(GetClassesInitial()) {
    on<GetClassesEvent>((event, emit) async {
      if (event is GetAllClassesEvent) {
        emit(LoadingClassesState());

        final failureOrClasses = await getAllClasses();

        emit(_mapFailureOrClassesToState(
            failureOrClasses)); //emite means return/send/...
      } else if (event is RefreshClassesEvent) {
        emit(LoadingClassesState());

        final failureOrClasses = await getAllClasses();
        emit(_mapFailureOrClassesToState(failureOrClasses));
      }
    });
  }

  GetClassesState _mapFailureOrClassesToState(
      Either<Failure, List<Class>> either) {
    return either.fold(
      (failure) => ErrorClassesState(message: _mapFailureToMessage(failure)),
      (classes) => LoadedClassesState(
        classes: classes,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
