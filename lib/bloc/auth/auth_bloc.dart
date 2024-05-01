import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat_app/utils/database_constants.dart';

import '../../services/database_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool obscureText = true;

  AuthBloc() : super(AuthInitialState()) {
    on<TogglePasswordVisibiltyEvent>(_togglePasswordVisibility);
    on<AuthButtonClickEvent>(_login);
    on<LogoutButtonClicked>(_logout);
  }

  Future<void> _logout(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await DatabaseService.put(
      DatabaseService.userBox,
      DatabaseConstants.currentUser,
      "",
    );
    emit(LogoutSuccessfulState());
  }

  Future<void> _togglePasswordVisibility(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(PasswordVisibilityOffState());
    if (obscureText) {
      emit(PasswordVisibilityOffState());
    } else {
      emit(PasswordVisibilityOnState());
    }
    obscureText = !obscureText;
  }

  Future<void> _login(
    AuthButtonClickEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final isValid = event.key.currentState!.validate();
      if (isValid) {
        String? user = DatabaseService.get(
          DatabaseService.userBox,
          event.userName,
        );
        if (user != null) {
          if (user == event.password) {
            await DatabaseService.put(
              DatabaseService.userBox,
              DatabaseConstants.currentUser,
              event.userName,
            );
            emit(AuthSuccessState());
          } else {
            emit(
              AuthFailedState(
                message: "Incorrect User Id/Password Combination",
              ),
            );
          }
        } else {
          if (event.isLoginFlow) {
            emit(
              AuthFailedState(
                message:
                    "User doesn't exists! To create a new user click on signUp",
              ),
            );
          } else {
            await DatabaseService.put(
              DatabaseService.userBox,
              event.userName,
              event.password,
            );
            await DatabaseService.put(
              DatabaseService.userBox,
              DatabaseConstants.currentUser,
              event.userName,
            );
            emit(AuthSuccessState());
          }
        }
      }
    } catch (err) {
      debugPrint('Something went wrong $err');
      emit(
        AuthErrorState(
          message: "Something went wrong! Please try again later",
        ),
      );
    }
  }
}
