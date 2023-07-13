part of 'get_classes_bloc.dart';

abstract class GetClassesState extends Equatable {
  const GetClassesState();
  
  @override
  List<Object> get props => [];
}

class GetClassesInitial extends GetClassesState {}

class LoadingClassesState extends GetClassesState {}

class LoadedClassesState extends GetClassesState {
  final List<Class> classes;

  const LoadedClassesState({required this.classes});

  @override
  List<Object> get props => [classes];
}

class ErrorClassesState extends GetClassesState {
  final String message;

  const ErrorClassesState({required this.message});

  @override
  List<Object> get props => [message];
}
