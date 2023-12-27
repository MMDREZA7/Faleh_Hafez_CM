import 'dart:io';
import 'package:faleh_hafez/application/theme_changer/theme_changer_bloc.dart';
import 'package:faleh_hafez/presentation/about/about_us.dart';
import 'package:faleh_hafez/presentation/home/components/exit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'button.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white24,
      shadowColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // logo
            DrawerHeader(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  child: Image.asset(
                    'assets/icon/f-green_background.png',
                  ),
                ),
              ),
            ),

            // name of app
            Container(
              padding: const EdgeInsets.only(top: 15),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  'فال حافظ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'iranNastaliq',
                    fontSize: 45,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.primary,
            ),

            // about us page
            MyButton(
              icon: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
              text: 'درباره ما',
              height: 60,
              width: double.infinity,
            ),

            // settings page
            MyButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onTap: () {
                context.read<ThemeChangerBloc>().add(ChangeThemeEvent());
              },
              text: 'عوض کردن تم',
              height: 60,
              width: double.infinity,
            ),

            // Exit button
            ExitButton(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'به امید دیدار',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'فراموشمون نکنیا',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                await Future.delayed(
                  const Duration(seconds: 2),
                );

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => exit(0),
                  ),
                );
              },
              text: 'خروج',
            ),
          ],
        ),
      ),
    );
  }
}
