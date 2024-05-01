import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/string_helper.dart';
import '../../services/web_socket_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketService _webSocketService;
  ChatBloc(this._webSocketService) : super(InitialChatState()) {
    on<GetInitialMessageEvent>(_getInitialMessages);
  }

  Future<void> _getInitialMessages(
    GetInitialMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      
    } catch (err) {
      debugPrint('Something went wrong - $err');
      emit(
        ChatErrorState(
          message: StringHelpers.errorMessage,
        ),
      );
    }
  }


}
