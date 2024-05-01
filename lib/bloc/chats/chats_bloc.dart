import 'dart:convert';

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
}
