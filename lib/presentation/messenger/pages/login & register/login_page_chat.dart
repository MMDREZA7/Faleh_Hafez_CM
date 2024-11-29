import 'package:faleh_hafez/application/authentiction/authentication_bloc.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:faleh_hafez/presentation/messenger/pages/login%20&%20register/register_page_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/chat_theme_changer/chat_theme_changer_bloc.dart';
import '../messenger_pages/home_page_chats.dart';

class LoginPageSecret extends StatefulWidget {
  const LoginPageSecret({super.key});

  @override
  State<LoginPageSecret> createState() => _LoginPageSecretState();
}

class _LoginPageSecretState extends State<LoginPageSecret> {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ورود به اکانت',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 25),
              const SizedBox(height: 25),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              cursorColor: Colors.white,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              controller: _mobileNumberController,
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
                              focusNode: _passwordFocusNode,
                              keyboardType: TextInputType.number,
                              controller: _passwordController,
                              cursorColor: Colors.white,
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
                    const SizedBox(height: 25),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is AuthenticationLoaded) {
                          return MaterialButton(
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
                                      ChatThemeChangerBloc,
                                      ChatThemeChangerState>(
                                    builder: (context, state) {
                                      if (state is ChatThemeChangerLoaded) {
                                        return MaterialApp(
                                          theme: state.theme,
                                          home: HomePageChats(
                                            userMobile:
                                                _mobileNumberController.text,
                                          ),
                                        );
                                      }
                                      return const HomePageChats(
                                          userMobile: 'hi');
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'ورود',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          );
                        }
                        if (state is AuthenticationError) {
                          return Column(
                            children: [
                              MaterialButton(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical: 25,
                                ),
                                color: Theme.of(context).colorScheme.secondary,
                                onPressed: () async {
                                  context.read<AuthenticationBloc>().add(
                                        LoginUser(
                                          user: User(
                                            password: _passwordController.text,
                                            mobileNumber:
                                                _mobileNumberController.text,
                                          ),
                                        ),
                                      );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocBuilder<
                                          ChatThemeChangerBloc,
                                          ChatThemeChangerState>(
                                        builder: (context, state) {
                                          if (state is ChatThemeChangerLoaded) {
                                            return MaterialApp(
                                              theme: state.theme,
                                              home: HomePageChats(
                                                userMobile:
                                                    _mobileNumberController
                                                        .text,
                                              ),
                                            );
                                          }
                                          return const HomePageChats(
                                              userMobile: 'hi');
                                        },
                                      ),
                                    ),
                                  );
                                  BlocProvider(
                                    create: (context) => AuthenticationBloc()
                                      ..add(
                                        LoginUser(
                                          user: User(
                                            password: _passwordController.text,
                                            mobileNumber:
                                                _mobileNumberController.text,
                                          ),
                                        ),
                                      ),
                                  );
                                },
                                child: Text(
                                  'ورود',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ),
                              Text(
                                state.errorText,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        }
                        return MaterialButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 25,
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () async {
                            context.read<AuthenticationBloc>().add(
                                  LoginUser(
                                    user: User(
                                      password: _passwordController.text,
                                      mobileNumber:
                                          _mobileNumberController.text,
                                    ),
                                  ),
                                );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocBuilder<
                                    ChatThemeChangerBloc,
                                    ChatThemeChangerState>(
                                  builder: (context, state) {
                                    if (state is ChatThemeChangerLoaded) {
                                      return MaterialApp(
                                        theme: state.theme,
                                        home: HomePageChats(
                                          userMobile:
                                              _mobileNumberController.text,
                                        ),
                                      );
                                    }
                                    return const HomePageChats(
                                        userMobile: 'hi');
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'ورود',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPageMessenger(),
                          ),
                        );
                      },
                      child: const Text(
                        "تا به حال اکانت نداشته اید؟",
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
