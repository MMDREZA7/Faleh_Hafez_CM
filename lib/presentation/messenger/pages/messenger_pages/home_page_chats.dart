// import 'package:faleh_hafez/application/chat_theme_changer/chat_theme_changer_bloc.dart';
import 'package:faleh_hafez/application/chat_items/chat_items_bloc.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:faleh_hafez/domain/user_chat.dart';
import 'package:faleh_hafez/presentation/messenger/components/drawer_chat.dart';
import 'package:faleh_hafez/presentation/messenger/pages/messenger_pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageChats extends StatelessWidget {
  final User user;

  const HomePageChats({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatItemsBloc()..add(ChatItemsGetItemsEvent(token: user.token)),
      child: Scaffold(
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
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () => context
                    .read<ChatItemsBloc>()
                    .add(ChatItemsGetItemsEvent(token: user.token)),
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).primaryColor,
                ),
              );
            }),
          ],
        ),
        drawer: DrawerHomeChat(
          user: user,
        ),
        body: BlocBuilder<ChatItemsBloc, ChatItemsState>(
          builder: (context, state) {
            if (state is ChatItemsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ChatItemsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ChatItemsBloc>()
                          .add(ChatItemsGetItemsEvent(token: user.token)),
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              );
            }
            if (state is ChatItemsLoaded) {
              return ListView.builder(
                itemCount: state.userChatItems.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          userChatItem: state.userChatItems[index],
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
                        state.userChatItems[index].id,
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
              );
            }
            return const Center(
              child: Text("No Chats available"),
            );
          },
        ),
      ),
    );
  }
}
