import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database_service.dart';
import '../../utils/database_constants.dart';

part 'chats_event.dart';
part 'chats_state.dart';

// Chats - ["afdwed","asefr","tdyhgv"];

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(InitialChatsState()) {
    on<GetUserChatsEvent>(_getUserChats);
    on<AddNewChatsEvent>(_addUserChats);
    on<DeleteChatEvent>(_deleteUserChats);
  }

  Future<void> _addUserChats(
    ChatsEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsLoadingState());
    String? user = DatabaseService.get(
      DatabaseService.userBox,
      DatabaseConstants.currentUser,
    );
    if (user != null) {
      String? userChatsString = DatabaseService.get(
        DatabaseService.userChats,
        user,
      );
      List<dynamic> userChats = json.decode(userChatsString ?? "[]");
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
        json.encode(userChats),
      );
      emit(ChatsLoadedState(userChats: userChats));
    }
  }

  Future<void> _getUserChats(
    ChatsEvent event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsLoadingState());
    try {
      String? user = DatabaseService.get(
        DatabaseService.userBox,
        DatabaseConstants.currentUser,
      );
      if (user != null) {
        String? chats = DatabaseService.get(
          DatabaseService.userChats,
          user,
        );
        emit(ChatsLoadedState(userChats: json.decode(chats ?? "[]")));
      }
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatsErrorState(
          message: "Something went wrong! Please try again later",
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
      String? user = DatabaseService.get(
        DatabaseService.userBox,
        DatabaseConstants.currentUser,
      );
      if (user != null) {
        String? userChatsString = DatabaseService.get(
          DatabaseService.userChats,
          user,
        );
        List<dynamic> userChats = json.decode(userChatsString ?? "[]");
        userChats.removeWhere((element) => element == event.chatId);
        await DatabaseService.put(
          DatabaseService.userChats,
          user,
          json.encode(userChats),
        );
        emit(ChatsLoadedState(userChats: userChats));
      }
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatsErrorState(
          message: "Something went wrong! Please try again later",
        ),
      );
    }
  }
}
