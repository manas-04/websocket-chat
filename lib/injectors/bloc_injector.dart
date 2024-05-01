import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/all_chats/all_chats_bloc.dart';

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
        BlocProvider(
          create: (context) => ChatsBloc(),
        ),
      ],
      child: child,
    );
  }
}
