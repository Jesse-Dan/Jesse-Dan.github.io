part of 'methods_cubit.dart';

abstract class MethodsState extends Equatable {
  const MethodsState();

  @override
  List<Object> get props => [];
}

class MethodsInitial extends MethodsState {}

class MethodsDone extends MethodsState {
  final bool open;

  MethodsDone(this.open);
}

class MethodsFailed extends MethodsState {
  final String e;

  MethodsFailed(this.e);
}
