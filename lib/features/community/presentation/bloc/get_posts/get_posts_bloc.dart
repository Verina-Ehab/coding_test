// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/use_cases/get_all_posts.dart';

part 'get_posts_event.dart';
part 'get_posts_state.dart';

class GetPostsBloc extends Bloc<GetPostsEvent, GetPostsState> {

  final GetAllPostsUsecase getAllPosts;

  GetPostsBloc(
     {required this.getAllPosts,}
  ) : super(GetPostsInitial()) {
    on<GetPostsEvent>((event, emit) async{
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        // getAllPosts will return something of type either<failure , list<post>>
        // so I will use fold to check if returned value
        // if failure do this
        // if list<post> do this
        
        emit(_mapFailureOrPostsToState(failureOrPosts)); //emite means return/send/...
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  GetPostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
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
