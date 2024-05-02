import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/all_chats/all_chats_bloc.dart';
import '../../routes/app_route_contants.dart';
import '/routes/auto_app_routes.dart';
import '/bloc/chat/chat_bloc.dart';

@RoutePage()
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
          style: TextStyle(
            color: Colors.white,
          ),
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
        onPressed: () => {context.read<ChatsBloc>().add(AddNewChatsEvent())},
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
              context.router.popAndPush(
                const LoginRoute(),
              )
            }
        },
        child: BlocConsumer<ChatsBloc, ChatsState>(
          listener: (context, state) {
            if (state is ChatTileClickedState) {
              context.router
                  .pushNamed(AppRouteConstants.chat)
                  .then((value) => context.read<ChatBloc>().closeConnection());
            }
          },
          builder: (context, state) {
            if (state is ChatsLoadedState) {
              if (state.userChats.isEmpty) {
                return const Center(
                  child: Text(
                    "Initiate a new chat!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 133, 150),
                      fontSize: 24,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.userChats.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        onTap: () => {
                          context.read<ChatsBloc>().add(
                                ChatTileClickEvent(
                                  chatID: state.userChats[index],
                                  chatList: state.userChats,
                                ),
                              )
                        },
                        tileColor: const Color.fromARGB(255, 223, 250, 255),
                        title: Text("Chat ID - ${state.userChats[index]}"),
                        trailing: InkWell(
                          onTap: () => {
                            context.read<ChatsBloc>().add(
                                DeleteChatEvent(chatId: state.userChats[index]))
                          },
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            if (state is ChatsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
