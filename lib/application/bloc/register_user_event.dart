part of 'register_user_bloc.dart';

@immutable
sealed class LogRegUserEvent {}

class RegisterUser extends LogRegUserEvent {
  final User user;

  RegisterUser({
    required this.user,
  });
}

class LoginUser extends LogRegUserEvent {
  final User user;

  LoginUser({
    required this.user,
  });
}

class CheckExistenceUser extends LogRegUserEvent {
  final String userName;

  CheckExistenceUser({
    required this.userName,
  });
}
