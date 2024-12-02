import 'package:faleh_hafez/domain/massage_dto.dart';

import '../../../../../../application/messaging/bloc/messaging_bloc.dart';
import '../../../../../core/empty_view.dart';
import '../../../../../core/failure_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/messaging/bloc/messaging_bloc.dart';
import '../models/chat_message_for_show.dart';
import 'chat_input_field.dart';
import 'chat_page_shimmer_loading.dart';
import 'message.dart';

class ChatPageMessagesListView extends StatelessWidget {
  final String hostPublicID, guestPublicID;
  final bool isGuest;
  final String? image;
  final ScrollController scrollController = ScrollController();

  ChatPageMessagesListView({
    super.key,
    required this.hostPublicID,
    required this.guestPublicID,
    required this.isGuest,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingBloc, MessagingState>(
      builder: (context, state) {
        if (state is MessagingError) {
          return FailureView(
            message: state.errorMessage,
            onTapTryAgain: () => context.read<MessagingBloc>()
              ..add(
                const MessagingGetMessages(chatID: '', token: ''),
              ),
          );
        }
        if (state is MessagingError) {
          return FailureView(
            message: state.errorMessage,
            onTapTryAgain: () => context.read<MessagingBloc>()
              ..add(
                const MessagingGetMessages(chatID: '', token: ''),
              ),
          );
        }
        if (state is MessagingLoadEmpty) {
          return Column(
            children: [
              const Expanded(
                child: EmptyView(message: 'No Messages Yet'),
              ),
              ChatInputField(
                guestPublicID: guestPublicID,
                hostPublicID: hostPublicID,
                isGuest: isGuest,
                // scrollControllerForMessagesList: scrollController,
              ),
            ],
          );
        }
        if (state is MessagingLoading) {
          return const ChatsPageShimmerLoading();
        }
        if (state is MessagingLoaded) {
          return _loadSuccessView(
            messages: state.messages,
            isGuest: isGuest,
            hostPublicID: hostPublicID,
            guestPublicID: guestPublicID,
            image: image,
          );
        }
        if (state is MessagingLoaded) {
          return _loadSuccessView(
            messages: state.messages,
            isGuest: isGuest,
            hostPublicID: hostPublicID,
            guestPublicID: guestPublicID,
            // scrollController: scrollController,
            image: image,
          );
        }
        return const Center(
          child: Text('Some error happened.'),
        );
      },
    );
  }
}

class _loadSuccessView extends StatelessWidget {
  _loadSuccessView({
    Key? key,
    required this.messages,
    required this.isGuest,
    required this.hostPublicID,
    required this.guestPublicID,
    // required this.scrollController,
    this.image,
  }) : super(key: key);

  final List<MessageDTO?> messages;
  final bool isGuest;
  final String hostPublicID;
  final String guestPublicID;
  // final ScrollController scrollController;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
                // controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) => const Text("Hello My Freind")
                // MessageDTO(
                //   token: '',
                //   text: '',
                //   reciverID: '',
                // ),
                ),
          ),
          // child: ChatInputField(
          //   guestPublicID: guestPublicID,
          //   hostPublicID: hostPublicID,
          //   isGuest: isGuest,
          //   // scrollControllerForMessagesList: scrollController,
          // ),
        ),
      ],
    );
  }
}
