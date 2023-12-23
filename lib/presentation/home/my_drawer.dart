import 'dart:io';
import 'package:faleh_hafez/presentation/about/about_us.dart';
import 'package:faleh_hafez/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

import 'my_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white24,
      shadowColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
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
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green[900],
              ),
              child: const Center(
                child: Text(
                  'فال حافظ',
                  style: TextStyle(
                    fontFamily: 'iranNastaliq',
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.green[900],
            ),
            MyButton(
              icon: const Icon(
                Icons.info,
                color: Colors.black,
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
              boxColor: Colors.green[900],
              textColor: Colors.white,
            ),
            MyButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              text: 'تنظیمات',
              height: 60,
              width: double.infinity,
              boxColor: Colors.green[900],
              textColor: Colors.white,
            ),
            MyButton(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.green[300],
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'به امید دیدار',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'فراموشمون نکنیا',
                          style: TextStyle(
                            color: Colors.white,
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
              height: 60,
              width: double.infinity,
              boxColor: Colors.red,
              textColor: Colors.white,
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
