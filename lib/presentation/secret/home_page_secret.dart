import 'package:faleh_hafez/application/theme_changer/theme_changer_bloc.dart';
import 'package:faleh_hafez/presentation/home/home_page.dart';
import 'package:flutter/material.dart';

class HomePageSecret extends StatelessWidget {
  final String title;
  final String password;

  const HomePageSecret({
    super.key,
    required this.password,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              DrawerButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaterialApp(
                        theme: mainTheme,
                        home: const HomePage(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Text(
                'Password: $password',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
