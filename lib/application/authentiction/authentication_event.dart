part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class RegisterUser extends AuthenticationEvent {
  final User user;

  RegisterUser({
    required this.user,
  });
}

class LoginUser extends AuthenticationEvent {
  final User user;

  LoginUser({
    required this.user,
  });
}
