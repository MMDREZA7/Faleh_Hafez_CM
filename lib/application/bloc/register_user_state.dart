part of 'register_user_bloc.dart';

@immutable
sealed class LogRegUserState {}

class LogRegUserInitial extends LogRegUserState {}

// ignore: camel_case_types
class logRegUserLoading extends LogRegUserState {}

class LogRegUserLoaded extends LogRegUserState {
  final User user;

  LogRegUserLoaded({
    required this.user,
  });
}

class LogRegUserError extends LogRegUserState {
  final String errorText;

  LogRegUserError({
    required this.errorText,
  });
}

class CheckExistenceUserState extends LogRegUserEvent {
  final String error;

  CheckExistenceUserState({
    required this.error,
  });
}
