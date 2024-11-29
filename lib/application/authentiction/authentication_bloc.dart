import 'package:bloc/bloc.dart';
import 'package:faleh_hafez/Service/APIService.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

List<User> userList = [];

late final String? errorText;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // ignore: unused_field
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(AuthenticationLoading());

      final response = ApiService().registerUser(
        event.user.mobileNumber,
        event.user.password,
      );

      emit(
        AuthenticationLoaded(
          user: event.user,
          responseMessage: response as String,
        ),
      );
      print("User Adding Successfully");
    });

    on<LoginUser>((event, emit) {
      emit(AuthenticationLoading());

      final findUser = userList.firstWhere(
        (element) => element.mobileNumber == event.user.mobileNumber,
        orElse: () {
          print('user not found');

          return User(
            password: event.user.password,
            mobileNumber: event.user.mobileNumber,
          );
        },
      );

      if (findUser.password == event.user.password) {
        emit(
          AuthenticationLoaded(user: event.user, responseMessage: 'hello'),
        );
        print('Successfuly');
        print(userList);
      } else if (findUser.password != event.user.password) {
        emit(
          AuthenticationError(errorText: 'password is false'),
        );
        print('password is false');
      } else if (findUser.mobileNumber.isEmpty) {
        emit(
          AuthenticationError(errorText: 'user not found'),
        );
      } else {
        emit(
          AuthenticationError(errorText: 'We have error'),
        );
        print('We have error');
      }
    });
  }
}
