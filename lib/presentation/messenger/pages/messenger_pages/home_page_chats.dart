import 'package:faleh_hafez/presentation/messenger/components/drawer_chat.dart';
import 'package:faleh_hafez/presentation/messenger/models/user.dart';
import 'package:faleh_hafez/presentation/messenger/pages/messenger_pages/chat_page.dart';
import 'package:faleh_hafez/presentation/themes/theme.dart';
import 'package:flutter/material.dart';

class HomePageChats extends StatelessWidget {
  final String userMobile;

  const HomePageChats({
    super.key,
    required this.userMobile,
  });

  @override
  Widget build(BuildContext context) {
    List<messager> users = [
      messager(name: 'ali'),
      messager(name: 'mmdreza'),
      messager(name: 'mahdi'),
      messager(name: 'mmd'),
      messager(name: 'habib'),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            'Messenger',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        drawer: DrawerHomeChat(
          userName: userMobile,
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    nameOfContent: users[index].name,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              margin: const EdgeInsets.only(
                top: 15,
                right: 15,
                left: 15,
              ),
              child: ListTile(
                title: Text(
                  users[index].name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
