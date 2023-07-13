part of 'get_classes_bloc.dart';

abstract class GetClassesEvent extends Equatable {
  const GetClassesEvent();

  @override
  List<Object> get props => [];
}

class GetAllClassesEvent extends GetClassesEvent {}

class RefreshClassesEvent extends GetClassesEvent {}
