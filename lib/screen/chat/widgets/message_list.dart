import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat/chat_bloc.dart';
import '../../../utils/size_helpers.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: context.read<ChatBloc>().messages!.length,
        itemBuilder: (context, index) {
          int length = context.read<ChatBloc>().messages!.length;
          String message =
              context.read<ChatBloc>().messages![length - index - 1]["msg"];
          bool isUserMessage =
              context.read<ChatBloc>().messages![length - index - 1]["user"] ==
                  context.read<ChatBloc>().currentUser;
          return Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
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
    );
  }
}
