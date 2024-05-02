import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database_service.dart';
import '../../utils/database_constants.dart';
import '../../utils/string_helper.dart';
import '../../services/web_socket_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String currentChat = "";
  String currentUser = "";
  List<dynamic>? messages = [];
  final WebSocketService _webSocketService;
  StreamSubscription<dynamic>? subscription;

  ChatBloc(this._webSocketService) : super(InitialChatState()) {
    on<GetInitialMessageEvent>(_getInitialMessages);
    on<ChatMessageReceiveEvent>(_processReceiveMessages);
    on<ChatMessageSendEvent>(_processSendMessage);
  }

  Future<void> setupConnectionAndListen() async {
    try {
      subscription?.cancel();

      currentChat = DatabaseService.get(
        DatabaseService.userChats,
        DatabaseConstants.currentChat,
      );

      // Create a new subscription
      subscription = _webSocketService.messageStream.listen((event) {
        add(
          ChatMessageReceiveEvent(
            chatID: currentChat,
            message: event.toString(),
          ),
        );
        debugPrint("Websocket Working");
      }, onError: (error) {
        debugPrint('Error: $error');
      }, onDone: () {
        debugPrint('Connection closed');
      });
    } catch (error) {
      debugPrint("Error while recieving message: $error");
    }
  }

  Future<void> _processSendMessage(
    ChatMessageSendEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      if (currentUser == "") {
        currentUser = DatabaseService.get(
          DatabaseService.userBox,
          DatabaseConstants.currentUser,
        );
      }
      await upsertMessages(event.message, currentUser);
      _webSocketService.sendMessage(event.message);
      emit(ChatLoadedState());
    } catch (err) {
      debugPrint("Error while sending message - $err");
      emit(ChatErrorState(message: "Error while sending message"));
    }
  }

  Future<void> _getInitialMessages(
    GetInitialMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      currentChat = DatabaseService.get(
        DatabaseService.userChats,
        DatabaseConstants.currentChat,
      );
      messages = DatabaseService.get(
        DatabaseService.seperateChatBox,
        currentChat,
      );
      if (messages == null) {
        messages = [];
        await DatabaseService.put(
          DatabaseService.seperateChatBox,
          currentChat,
          [],
        );
      }
      emit(ChatLoadedState());
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatErrorState(
          message: StringHelpers.errorMessage,
        ),
      );
    }
  }

  Future<void> _processReceiveMessages(
    ChatMessageReceiveEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoadingState());
      await upsertMessages(event.message, event.chatID);
      emit(ChatLoadedState());
    } catch (err) {
      debugPrint("Error while receiving message - $err");
      emit(ChatErrorState(message: "Error while receiving message"));
    }
  }

  Future<void> closeConnection() async {
    if (subscription != null) {
      await subscription!.cancel();
      subscription = null;
    }
    try {
      _webSocketService.closeConnection();
      debugPrint("Websocket closed successfully");
    } catch (error) {
      debugPrint("Error while closing websocket connection: $error");
    }
  }

  Future<void> upsertMessages(message, user) async {
    messages = await DatabaseService.get(
      DatabaseService.seperateChatBox,
      currentChat,
    );
    if (messages != null) {
      messages!.add({"msg": message, "user": user});
    } else {
      messages = [
        {"msg": message, "user": user}
      ];
    }
    await DatabaseService.put(
      DatabaseService.seperateChatBox,
      currentChat,
      messages,
    );
  }
}
