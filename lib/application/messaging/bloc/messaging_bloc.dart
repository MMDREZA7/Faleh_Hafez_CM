import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:faleh_hafez/Service/APIService.dart';
import 'package:faleh_hafez/domain/massage_dto.dart';
import 'package:equatable/equatable.dart';
import '../../../Service/APIService.dart';
part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  // final FileRepository _fileRepository;
  // final FileHandler _fileHandler;
  // final Guid _guid;
  late List<MessageDTO?> allMessagesList = [];

  MessagingBloc() : super(MessagingInitial()) {
    on<MessagingGetMessages>(_fetchMessages);
    on<MessagingSendMessage>(_sendMessage);
    // on<MessagingSendFileMessage>(_sendFileMessage);
    // on<MessagingSeenMessage>(_seenMessage);
    // on<MessagingDeleteMessage>(_deleteMessage);
    // on<MessagingDownloadFile>(_downloadFileMessage);
  }

  FutureOr<void> _fetchMessages(
    MessagingGetMessages event,
    Emitter<MessagingState> emit,
  ) async {
    emit(MessagingLoading());

    try {
      final response = await APIService().getMessagesChat(
        chatID: event.chatID,
        token: event.token,
      );

      emit(
        MessagingLoaded(messages: response),
      );
    } catch (e) {
      emit(
        MessagingError(
          errorMessage: e.toString().split(':')[1],
        ),
      );
    }
  }

  FutureOr<void> _sendMessage(
    MessagingSendMessage event,
    Emitter<MessagingState> emit,
  ) async {
    emit(MessagingLoading());

    try {
      var response = await APIService().sendMessage(
        token: event.message.token,
        receiverID: event.message.reciverID,
        text: event.message.text,
      );

      final List<MessageDTO> messages = [];

      final getMessages = add(
        MessagingGetMessages(chatID: event.chatID, token: event.message.token),
      );

      emit(
        MessagingLoaded(messages: messages),
      );
    } catch (e) {
      emit(
        MessagingError(
          errorMessage: e.toString().split(':')[1],
        ),
      );
    }
  }

  // FutureOr<void> _sendFileMessage(
  //   MessagingSendFileMessage event,
  //   Emitter<MessagingState> emit,
  // ) async {
  //   emit(MessagingLoadInProgress());

  //   final fileResult = await _fileHandler.pickFile();

  //   await fileResult.fold(
  //     (canceled) => MessagingSendMessageSuccess(messages: allMessagesList),
  //     (file) async {
  //       String fileId = _guid.genarateId();
  //       String fileType = extension(file.path);

  //       String fileName = file.path.split('/').last.split('.').first;
  //       String folderName = DateFormat('yy-MM-dd').format(DateTime.now());
  //       print('fileName-folderName: $fileName $folderName');
  //       print('fileType: $fileType');

  //       final result = await _fileRepository.uploadFile(
  //         file: file,
  //         fileInfo: FileInfo(
  //           folderName: folderName,
  //           fileName: fileName,
  //           fileType: fileType,
  //           fileID: fileId,
  //         ),
  //       );

  //       await result.fold(
  //         (fail) {
  //           return MessagingUploadFileFiled(fail: fail);
  //         },
  //         (fileID) async {
  //           var fileMessage = event.message
  //             ..fileFileID = fileId
  //             ..fileFileName = fileName
  //             ..fileFolderName = folderName
  //             ..fileType = fileType;

  //           fileMessage.text =
  //               file.path.split('/').last; // This is file Title in ChatPage

  //           var result = await _APIService.sendMessage(
  //             senderPublicID: event.message.senderPublicID,
  //             receiverPublicID: event.message.receiverPublicID,
  //             message: fileMessage,
  //           );

  //           final newState = result.fold(
  //             (fail) => MessagingSendMessageFailed(fail),
  //             (message) {
  //               allMessagesList.add(message);
  //               return MessagingSendMessageSuccess(messages: allMessagesList);
  //             },
  //           );

  //           emit(newState);
  //         },
  //       );
  //     },
  //   );
  // }

  // FutureOr<void> _seenMessage(
  //   MessagingSeenMessage event,
  //   Emitter<MessagingState> emit,
  // ) {}

  // FutureOr<void> _deleteMessage(
  //   MessagingDeleteMessage event,
  //   Emitter<MessagingState> emit,
  // ) async {
  //   emit(MessagingLoadInProgress());

  //   var result = await _APIService.deleteMessage(
  //     messageID: event.messageID,
  //   );

  //   final newState = result.fold(
  //     (fail) => MessagingLoadFail(fail: fail),
  //     (deletedMessageID) {
  //       allMessagesList.remove(
  //         allMessagesList.firstWhere(
  //             (element) => element!.id.toString() == deletedMessageID),
  //       );
  //       return MessagingLoadSuccess(messages: allMessagesList);
  //     },
  //   );

  //   emit(newState);
  // }

  // FutureOr<void> _downloadFileMessage(
  //   MessagingDownloadFile event,
  //   Emitter<MessagingState> emit,
  // ) async {
  //   emit(MessagingDownloadingFile());
  //   //! Complete Here
  //   print('File Type: ' + event.fileInfo.fileType.toString());
  //   final result = await _fileRepository.downloadFile(
  //     fileInfo: event.fileInfo,
  //   );

  //   await result.fold(
  //     (fail) => MessagingLoadSuccess(messages: allMessagesList),
  //     (file) {
  //       _fileHandler.openThisFile(file: File(file.path));
  //       emit(MessagingLoadSuccess(messages: allMessagesList));
  //     },
  //   );
  // }
}
