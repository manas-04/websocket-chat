part of 'chat_bloc.dart';

class ChatEvent {}

class GetInitialMessageEvent extends ChatEvent {}

class ChatMessageSendEvent extends ChatEvent {
  final String message;

  ChatMessageSendEvent({required this.message});
}

class ChatMessageReceiveEvent extends ChatEvent {
  final String chatID;
  final String message;

  ChatMessageReceiveEvent({required this.chatID, required this.message});
}
