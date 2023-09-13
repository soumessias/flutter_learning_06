import 'package:flutter/material.dart';
import 'package:flutter_learning_06/components/messages.dart';
import 'package:flutter_learning_06/components/new_message.dart';
import 'package:flutter_learning_06/core/services/auth/auth_service.dart';
import 'package:flutter_learning_06/core/services/notification/chat_notification_service.dart';
import 'package:flutter_learning_06/pages/notification_page.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat dos Marombas",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => NotificationPage())),
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.redAccent,
                  child: Text(
                    "${Provider.of<ChatNotificationService>(context).itemsCount}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => AuthService().logout(),
            child: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     color: Theme.of(context).primaryColor,
      //   ),
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(
      //       context,
      //       listen: false,
      //     ).add(ChatNotification(
      //       title: "Mais uma Notificação",
      //       body: Random().nextDouble().toString(),
      //     ));
      //   },
      // ),
    );
  }
}
