import 'dart:math';

import 'package:faleh_hafez/application/chat_theme_changer/chat_theme_changer_bloc.dart';
import 'package:faleh_hafez/presentation/messenger/components/drawer_chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerHomeChat extends StatefulWidget {
  final String userName;

  const DrawerHomeChat({
    super.key,
    required this.userName,
  });

  @override
  State<DrawerHomeChat> createState() => _DrawerHomeChatState();
}

class _DrawerHomeChatState extends State<DrawerHomeChat> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  widget.userName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            DrawerItemChat(
              boxColor: Colors.blue,
              text: 'Profile',
              onTap: () {},
              icon: Icons.person,
            ),
            const SizedBox(height: 25),
            DrawerItemChat(
              boxColor: Colors.grey,
              text: 'Settings',
              onTap: () async {
                await Future.delayed(
                  const Duration(seconds: 1),
                );
                // ignore: use_build_context_synchronously
                context.read<ChatThemeChangerBloc>().add(ChangeChatPageTheme());
              },
              icon: Icons.settings,
            ),
            const SizedBox(height: 25),
            DrawerItemChat(
              boxColor: Colors.red,
              text: 'logout',
              onTap: () {},
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }
}
