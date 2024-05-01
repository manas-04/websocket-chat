part of 'chats_bloc.dart';

class ChatsEvent {}

class GetUserChatsEvent extends ChatsEvent {}

class AddNewChatsEvent extends ChatsEvent {}

class DeleteChatEvent extends ChatsEvent {
  final String chatId;

  DeleteChatEvent({required this.chatId});
}
