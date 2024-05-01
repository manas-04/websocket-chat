part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class PasswordVisibilityOnState extends AuthState {
  @override
  List<Object?> get props => [];
}

class PasswordVisibilityOffState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFailedState extends AuthState {
  final String message;

  AuthFailedState({required this.message});
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
