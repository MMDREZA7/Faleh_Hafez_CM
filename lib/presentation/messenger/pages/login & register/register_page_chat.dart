import 'package:faleh_hafez/presentation/messenger/pages/login%20&%20register/login_page_chat.dart';
import 'package:faleh_hafez/presentation/messenger/pages/messenger_pages/home_page_chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/chat_theme_changer/chat_theme_changer_bloc.dart';
import '../../../../application/register_login/register_user_bloc.dart';

class RegisterPageMessenger extends StatefulWidget {
  const RegisterPageMessenger({super.key});

  @override
  State<RegisterPageMessenger> createState() => _RegisterPageMessengerState();
}

class _RegisterPageMessengerState extends State<RegisterPageMessenger> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                    // username feild
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
                              focusNode: _userNameFocusNode,
                              controller: _userNameController,
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
                                hintText: 'نام کاربری',
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
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocBuilder<
                                ChatThemeChangerBloc, ChatThemeChangerState>(
                              builder: (context, state) {
                                if (state is ChatThemeChangerLoaded) {
                                  return MaterialApp(
                                    theme: state.theme,
                                    home: HomePageChats(
                                      nameOfUser: _userNameController.text,
                                    ),
                                  );
                                }
                                return const HomePageChats(nameOfUser: 'hi');
                              },
                            ),
                          ),
                        );
                      },
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
                              create: (context) => LogRegUserBloc(),
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
