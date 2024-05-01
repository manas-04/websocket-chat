part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class PasswordVisibilityOnState extends AuthState {}

class PasswordVisibilityOffState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailedState extends AuthState {
  final String message;

  AuthFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogoutSuccessfulState extends AuthState {}
