import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat_app/utils/size_helpers.dart';

import '../../bloc/chat/chat_bloc.dart';
import '../../screen/chat/widgets/message_box.dart';

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
            onTap: () => {Navigator.of(context).pop()},
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: context.read<ChatBloc>().messages!.length,
                itemBuilder: (context, index) {
                  int length = context.read<ChatBloc>().messages!.length;
                  String message = context
                      .read<ChatBloc>()
                      .messages![length - index - 1]["msg"];
                  bool isUserMessage = context
                          .read<ChatBloc>()
                          .messages![length - index - 1]["user"] ==
                      context.read<ChatBloc>().currentUser;
                  return Row(
                    mainAxisAlignment: isUserMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? const Color.fromARGB(255, 1, 133, 150)
                              : Colors.purple,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(14),
                            topRight: isUserMessage
                                ? const Radius.circular(0)
                                : const Radius.circular(14),
                            bottomLeft: !isUserMessage
                                ? const Radius.circular(0)
                                : const Radius.circular(14),
                            bottomRight: const Radius.circular(14),
                          ),
                        ),
                        width: SizeHelpers.screenWidth(context) * 0.4,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 14,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            MessageBox(
              messageController: _messageController,
            )
          ],
        ),
      ),
    );
  }
}
