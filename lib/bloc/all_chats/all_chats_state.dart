part of 'all_chats_bloc.dart';

class ChatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialChatsState extends ChatsState {}

class ChatsLoadingState extends ChatsState {}

class ChatTileClickedState extends ChatsState {}

class ChatsLoadedState extends ChatsState {
  final List<dynamic> userChats;
  ChatsLoadedState({required this.userChats});
}

class ChatsErrorState extends ChatsState {
  final String message;

  ChatsErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
