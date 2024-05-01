part of 'all_chats_bloc.dart';

class ChatsEvent {}

class GetUserChatsEvent extends ChatsEvent {}

class AddNewChatsEvent extends ChatsEvent {}

class ChatTileClickEvent extends ChatsEvent {
  final String chatID;
  final List<dynamic> chatList;

  ChatTileClickEvent({required this.chatID, required this.chatList});
}

class DeleteChatEvent extends ChatsEvent {
  final String chatId;

  DeleteChatEvent({required this.chatId});
}
