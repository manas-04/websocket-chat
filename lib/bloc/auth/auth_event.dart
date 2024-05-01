part of 'auth_bloc.dart';

class AuthEvent {}

class TogglePasswordVisibiltyEvent extends AuthEvent {}

class ToggleSignUpEvent extends AuthEvent {
  final bool isSignUpFlow;
  ToggleSignUpEvent({required this.isSignUpFlow});
}

class AuthButtonClickEvent extends AuthEvent {
  final GlobalKey<FormState> key;
  final String userName;
  final String password;
  final bool isLoginFlow;

  AuthButtonClickEvent({
    required this.key,
    required this.userName,
    required this.password,
    required this.isLoginFlow,
  });
}
