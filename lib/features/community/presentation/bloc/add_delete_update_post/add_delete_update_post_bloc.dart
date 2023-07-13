// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/use_cases/add_post.dart';
import '../../../domain/use_cases/delete_post.dart';
import '../../../domain/use_cases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {

  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;

  AddDeleteUpdatePostBloc({required this.addPost, required this.updatePost, required this.deletePost}) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async{
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrFailureState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrFailureState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrFailureState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrFailureState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
      (_) => MessageAddDeleteUpdatePostState(
        message: message,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
