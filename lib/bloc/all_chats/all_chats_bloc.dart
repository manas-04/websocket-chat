import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/string_helper.dart';
import '../../services/database_service.dart';
import '../../utils/database_constants.dart';

part 'all_chats_event.dart';
part 'all_chats_state.dart';

// Chats - ["afdwed","asefr","tdyhgv"];

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(InitialChatsState()) {
    on<GetUserChatsEvent>(_getUserChats);
    on<AddNewChatsEvent>(_addUserChats);
    on<DeleteChatEvent>(_deleteUserChats);
    on<ChatTileClickEvent>(_chatTileClicked);
  }

  Future<void> _chatTileClicked(
    ChatTileClickEvent event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      await DatabaseService.put(
        DatabaseService.userChats,
        DatabaseConstants.currentChat,
        event.chatID,
      );
      emit(ChatTileClickedState());
      emit(ChatsLoadedState(userChats: event.chatList));
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatsErrorState(
          message: StringHelpers.errorMessage,
        ),
      );
    }
  }

  Future<void> _addUserChats(
    ChatsEvent event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      emit(ChatsLoadingState());
      String? user = DatabaseService.getCurrentUser();
      if (user != null) {
        List<dynamic>? userChatsString = DatabaseService.get(
          DatabaseService.userChats,
          user,
        );
        List<dynamic> userChats = userChatsString ?? [];
        const charset =
            'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        Random random = Random();
        String code = String.fromCharCodes(
          Iterable.generate(
            6,
            (_) => charset.codeUnitAt(
              random.nextInt(
                charset.length,
              ),
            ),
          ),
        );
        userChats.add(code);
        await DatabaseService.put(
          DatabaseService.userChats,
          user,
          userChats,
        );
        emit(ChatsLoadedState(userChats: userChats));
      }
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatsErrorState(
          message: StringHelpers.errorMessage,
        ),
      );
    }
  }

  Future<void> _getUserChats(
    ChatsEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsLoadingState());
    try {
      String? user = DatabaseService.getCurrentUser();
      if (user != null) {
        List<dynamic>? chats = DatabaseService.get(
          DatabaseService.userChats,
          user,
        );
        emit(ChatsLoadedState(userChats: chats ?? []));
      }
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatsErrorState(
          message: StringHelpers.errorMessage,
        ),
      );
    }
  }

  Future<void> _deleteUserChats(
    DeleteChatEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsLoadingState());
    try {
      String? user = DatabaseService.getCurrentUser();
      if (user != null) {
        List<dynamic>? userChatsString = DatabaseService.get(
          DatabaseService.userChats,
          user,
        );
        List<dynamic> userChats = userChatsString ?? [];
        userChats.removeWhere((element) => element == event.chatId);
        await DatabaseService.put(
          DatabaseService.userChats,
          user,
          userChats,
        );
        emit(ChatsLoadedState(userChats: userChats));
      }
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatsErrorState(
          message: StringHelpers.errorMessage,
        ),
      );
    }
  }
}
