import 'package:faleh_hafez/application/bloc/register_user_bloc.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:faleh_hafez/presentation/secret/home_page_secret.dart';
import 'package:faleh_hafez/presentation/secret/login_page_secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageSecret extends StatefulWidget {
  const RegisterPageSecret({super.key});

  @override
  State<RegisterPageSecret> createState() => _RegisterPageSecretState();
}

class _RegisterPageSecretState extends State<RegisterPageSecret> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                              controller: _userNameController,
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
                              keyboardType: TextInputType.number,
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
                              controller: _confirmPasswordController,
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
                        context.read<LogRegUserBloc>().add(
                              LoginUser(
                                user: User(password: '', userName: ''),
                              ),
                            );
                        if (_passwordController.text.length < 6) {
                          await showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'پسورد باید از 6 رقم بیشتر باشد لطفا آن را اصلاح کنید',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          if (_confirmPasswordController.text !=
                              _passwordController.text) {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.red[300],
                                content: const Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    'تایید پسورد با پسورد یکسان نیست لطفا آن را چک کنید',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            context.read<LogRegUserBloc>().add(
                                  RegisterUser(
                                    user: User(
                                      password: _passwordController.text,
                                      userName: _userNameController.text,
                                    ),
                                  ),
                                );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageSecret(
                                  password: _passwordController.text,
                                  title: _userNameController.text,
                                ),
                              ),
                            );
                          }
                        }
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
