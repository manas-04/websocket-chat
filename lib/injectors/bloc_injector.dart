import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat_app/bloc/auth/auth_bloc.dart';

class BlocInjector extends StatelessWidget {
  final Widget child;
  const BlocInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: child,
    );
  }
}
