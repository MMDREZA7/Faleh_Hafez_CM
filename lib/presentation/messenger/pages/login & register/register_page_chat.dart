import 'package:faleh_hafez/application/authentiction/authentication_bloc.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:faleh_hafez/presentation/messenger/pages/login%20&%20register/login_page_chat.dart';
import 'package:faleh_hafez/presentation/messenger/pages/messenger_pages/home_page_chats.dart';
import 'package:faleh_hafez/presentation/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/chat_theme_changer/chat_theme_changer_bloc.dart';

class RegisterPageMessenger extends StatefulWidget {
  const RegisterPageMessenger({super.key});

  @override
  State<RegisterPageMessenger> createState() => _RegisterPageMessengerState();
}

class _RegisterPageMessengerState extends State<RegisterPageMessenger> {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode _mobileNumberFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    void handleRegister() async {
      if (_mobileNumberController.text == '') {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red[900],
            title: const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'شماره تلفن خود را وارد کنید',
              ),
            ),
          ),
        );
      }
      if (_mobileNumberController.text.length != 11) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red[900],
            title: const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'شماره تلفن باید 11  رقمی باشد و با 09 شروع شود',
              ),
            ),
          ),
        );
      }
      if (_passwordController.text == '') {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red[900],
            title: const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'رمز خود را وارد کنید',
              ),
            ),
          ),
        );
      }
      if (_confirmPasswordController.text == '') {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red[900],
            title: const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تاییدیه رمز خود را وارد کنید',
              ),
            ),
          ),
        );
      } else if (_passwordController.text != _confirmPasswordController.text) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red[900],
            title: const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'رمز و تاییدیه رمز باید با هم برابر باشد',
              ),
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BlocBuilder<ChatThemeChangerBloc, ChatThemeChangerState>(
              builder: (context, state) {
                if (state is ChatThemeChangerLoaded) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const AlertDialog(title: Text('You was Registered!')),
                  );
                  return MaterialApp(
                    theme: darkTheme,
                    debugShowCheckedModeBanner: false,
                    home: HomePageChats(
                      userMobile: _mobileNumberController.text,
                    ),
                  );
                }
                return const HomePageChats(userMobile: '09000000000');
              },
            ),
          ),
        );
        BlocProvider(
          create: (context) => AuthenticationBloc()
            ..add(
              RegisterUser(
                user: User(
                    password: _passwordController.text,
                    mobileNumber: _mobileNumberController.text),
              ),
            ),
        );
      }

      BlocProvider(
        create: (context) => AuthenticationBloc()
          ..add(
            RegisterUser(
              user: User(
                password: _passwordController.text,
                mobileNumber: _mobileNumberController.text.toString(),
              ),
            ),
          ),
      );
    }

    String? errorText;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'ساخت اکانت جدید',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // mobileNumber feild
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          title:
                              // Directionality(
                              // textDirection: TextDirection.rtl,
                              // child:
                              TextFormField(
                            focusNode: _mobileNumberFocusNode,
                            controller: _mobileNumberController,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            cursorColor: Colors.white,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'شماره تلفن',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          // ),
                        ),
                      ),
                    ),

                    // password feild
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          title: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_confirmPasswordFocusNode);
                              },
                              keyboardType: TextInputType.number,
                              focusNode: _passwordFocusNode,
                              controller: _passwordController,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'رمز عبور',
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // confirm password feild
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          title: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              showCursor: true,
                              focusNode: _confirmPasswordFocusNode,
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                errorText: errorText,
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'تایید رمز عبور',
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 25,
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () async {},
                      child: Text(
                        'ثبت نام',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthenticationBloc(),
                              child: const LoginPageSecret(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "اکانت داشته اید؟",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
