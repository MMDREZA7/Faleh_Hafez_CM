import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'register_user_event.dart';
part 'register_user_state.dart';

List<User> userList = [];

late final String? errorText;

class LogRegUserBloc extends Bloc<LogRegUserEvent, LogRegUserState> {
  final _myBox = Hive.box('mybox');
  LogRegUserBloc() : super(LogRegUserInitial()) {
    on<RegisterUser>((event, emit) async {
      final findUser = userList.firstWhere(
        (element) => element.userName == event.user.userName,
        orElse: () {
          emit(
            LogRegUserError(errorText: 'خوش آمدید'),
          );
          emit(logRegUserLoading());

          userList.add(event.user);

          emit(
            LogRegUserLoaded(
              user: event.user,
            ),
          );
          return User(
              password: event.user.password, userName: event.user.userName);
        },
      );

      if (findUser != null) {
        emit(
          LogRegUserError(errorText: 'این نام کاربری وجود دارد'),
        );
      }
    });
    on<LoginUser>((event, emit) {
      emit(logRegUserLoading());

      final findUser = userList.firstWhere(
        (element) => element.userName == event.user.userName,
        orElse: () {
          print('user not found');
          return userList.first;
        },
      );

      if (findUser.password == event.user.password) {
        emit(
          LogRegUserLoaded(
            user: event.user,
          ),
        );
        print('Successfuly');
        print(userList);
      } else if (findUser.password != event.user.password) {
        emit(
          LogRegUserError(errorText: 'password is false'),
        );
        print('password is false');
      } else if (findUser.userName.isEmpty) {
        emit(
          LogRegUserError(errorText: 'user not found'),
        );
      } else {
        emit(
          LogRegUserError(errorText: 'We have error'),
        );
        print('We have error');
      }
    });

    // on<CheckExistenceUser>(
    //   (event, emit) {
    //     final uesrNameChecked = userList.firstWhere(
    //       (element) => element.userName == event.userName,
    //     );
    //     if (uesrNameChecked.isNull) {
    //       emit(
    //         CheckExistenceUserState(error: 'welcome') as LogRegUserState,
    //       );
    //     } else {
    //       emit(
    //         CheckExistenceUserState(error: 'این نام کاربری وجود دارد')
    //             as LogRegUserState,
    //       );
    //     }
    //   },
    // );
  }
}
