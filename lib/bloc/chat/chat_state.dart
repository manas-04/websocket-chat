part of 'chat_bloc.dart';

class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialChatState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState({required this.message});
}
