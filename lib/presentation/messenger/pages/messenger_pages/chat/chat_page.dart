import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/messaging/bloc/messaging_bloc.dart';
import 'components/ChatPageMessagesView.dart';

class ChatPage extends StatelessWidget {
  final String hostPublicID, guestPublicID, name;
  final bool isGuest;
  final String chatID;
  final String token;

  const ChatPage({
    Key? key,
    required this.hostPublicID,
    required this.guestPublicID,
    required this.name,
    required this.isGuest,
    required this.chatID,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagingBloc()
        ..add(
          MessagingGetMessages(
            chatID: chatID,
            token: token,
          ),
        ),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: ChatPageMessagesListView(
          hostPublicID: hostPublicID,
          guestPublicID: guestPublicID,
          isGuest: isGuest,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
              BlocBuilder<MessagingBloc, MessagingState>(
                builder: (context, state) {
                  if (state is MessagingLoading) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(fontSize: 12),
                    );
                  } else if (state is MessagingLoaded) {
                    return const Text(
                      'Hello My Friend',
                      style: TextStyle(fontSize: 12),
                    );
                  } else {
                    return const Text(
                      '',
                      style: TextStyle(fontSize: 12),
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            context.read<MessagingBloc>().add(
                  MessagingGetMessages(
                    chatID: chatID,
                    token: token,
                  ),
                );
          },
        ),
      ],
    );
  }
}
