import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/chats/chats_bloc.dart';
import '../../utils/app_route_contants.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ChatsBloc>().add(GetUserChatsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 1, 133, 150),
        title: const Text(
          "Welcome!",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () => {context.read<AuthBloc>().add(LogoutButtonClicked())},
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        backgroundColor: const Color.fromARGB(255, 1, 133, 150),
        label: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "Add a new Chat",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => {
          if (state is LogoutSuccessfulState)
            {
              Navigator.pushReplacementNamed(
                context,
                AppRouteConstants.home,
              )
            }
        },
        child: Container(),
      ),
    );
  }
}
