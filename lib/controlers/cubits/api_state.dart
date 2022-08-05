part of 'api_cubit.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoaded extends ApiState {
  AppModel model;

  ApiLoaded({required this.model});
}

class ApiError extends ApiState {
  String erro;

  ApiError({required this.erro});
}

class ApiLoading extends ApiState {}
