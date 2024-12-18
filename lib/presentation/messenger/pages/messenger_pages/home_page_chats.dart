import 'package:faleh_hafez/application/chat_items/chat_items_bloc.dart';
import 'package:faleh_hafez/domain/user.dart';
import 'package:faleh_hafez/presentation/messenger/components/drawer_chat.dart';
import 'package:faleh_hafez/presentation/messenger/pages/messenger_pages/chat/chat_page.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageChats extends StatefulWidget {
  final User user;

  const HomePageChats({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageChatsState createState() => _HomePageChatsState();
}

class _HomePageChatsState extends State<HomePageChats> {
  late final TextEditingController _receiverUserIDController;

  @override
  void initState() {
    super.initState();
    _receiverUserIDController = TextEditingController();
  }

  @override
  void dispose() {
    _receiverUserIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatItemsBloc()
        ..add(ChatItemsGetItemsEvent(token: widget.user.token)),
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
            IconButton(
              onPressed: () => context
                  .read<ChatItemsBloc>()
                  .add(ChatItemsGetItemsEvent(token: widget.user.token)),
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        drawer: DrawerHomeChat(user: widget.user),
        body: BlocBuilder<ChatItemsBloc, ChatItemsState>(
          builder: (context, state) {
            if (state is ChatItemsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ChatItemsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(
                      onPressed: () => context.read<ChatItemsBloc>().add(
                          ChatItemsGetItemsEvent(token: widget.user.token)),
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              );
            }
            if (state is ChatItemsLoaded) {
              return ListView.builder(
                itemCount: state.userChatItems.length,
                itemBuilder: (context, index) {
                  final chatItem = state.userChatItems[index];
                  final isHost = widget.user.id == chatItem.participant1ID;
                  final hostID = isHost
                      ? chatItem.participant1ID
                      : chatItem.participant2ID;
                  final guestID = isHost
                      ? chatItem.participant2ID
                      : chatItem.participant1ID;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            chatID: chatItem.id,
                            token: widget.user.token,
                            hostPublicID: hostID,
                            guestPublicID: guestID,
                            isGuest: true,
                            name: '',
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
                      margin: const EdgeInsets.symmetric(
                        vertical: 7.5,
                        horizontal: 15,
                      ),
                      child: ListTile(
                        title: Text(
                          isHost
                              ? chatItem.participant2ID
                              : chatItem.participant1ID,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("No Chats available"));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add New Message To New User',
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Receiver ID'),
                        controller: _receiverUserIDController,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_receiverUserIDController.text.isEmpty) {
                              context.showErrorBar(
                                content: const Text(
                                  "The Receiver ID field is required.",
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    token: widget.user.token,
                                    chatID: '',
                                    hostPublicID: widget.user.id,
                                    guestPublicID:
                                        _receiverUserIDController.text,
                                    name: '',
                                    isGuest: true,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
