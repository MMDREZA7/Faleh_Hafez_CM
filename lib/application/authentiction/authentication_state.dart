part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {
  final User user;
  final String responseMessage;

  AuthenticationLoaded({
    required this.user,
    required this.responseMessage,
  });
}

class AuthenticationError extends AuthenticationState {
  final String errorText;

  AuthenticationError({
    required this.errorText,
  });
}
