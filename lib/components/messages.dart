import 'package:flutter/material.dart';
import 'package:flutter_learning_06/components/message_bubble.dart';
import 'package:flutter_learning_06/core/models/chat_message.dart';
import 'package:flutter_learning_06/core/services/auth/auth_service.dart';
import 'package:flutter_learning_06/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "Sem mensagens =(",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                // fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) => MessageBubble(
              key: ValueKey(msgs[index].id),
              message: msgs[index],
              belongsToCurrentUser: currentUser?.id == msgs[index].userId,
            ),
            itemCount: msgs.length,
          );
        }
      },
    );
  }
}
