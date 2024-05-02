import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat/chat_bloc.dart';
import '../../screen/chat/widgets/message_box.dart';
import '/screen/chat/widgets/message_list.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().setupConnectionAndListen();
    context.read<ChatBloc>().add(GetInitialMessageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 133, 150),
          title: Text(
            "Chat ID - ${context.read<ChatBloc>().currentChat}",
            style: const TextStyle(color: Colors.white),
          ),
          leading: InkWell(
            onTap: () => {context.router.back()},
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ignore: prefer_const_constructors
            MessageList(),
            MessageBox(
              messageController: _messageController,
            )
          ],
        ),
      ),
    );
  }
}
