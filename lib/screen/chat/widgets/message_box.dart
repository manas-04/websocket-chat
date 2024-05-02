import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color_helpers.dart';
import '/bloc/chat/chat_bloc.dart';

class MessageBox extends StatelessWidget {
  final TextEditingController _messageController;
  const MessageBox({
    super.key,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: _messageController,
              key: const ValueKey('message'),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                hintText: "Message",
                focusColor: const Color.fromRGBO(255, 0, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (_messageController.text.trim() != "") {
              context.read<ChatBloc>().add(
                    ChatMessageSendEvent(
                      message: _messageController.text,
                    ),
                  );
              _messageController.clear();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorHelpers.primaryLight,
            ),
            child: const Icon(
              Icons.send,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
