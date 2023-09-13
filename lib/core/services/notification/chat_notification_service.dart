import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_06/core/models/chat_notification.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // Push Notification
  Future<void> init() async {
    await _configureTerminated();
    await _configureBackground();
    await _configureForeground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMsg =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }

  void _messageHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;

    add(ChatNotification(
      title: msg.notification!.title ?? "Not informed",
      body: msg.notification!.body ?? "Not informed",
    ));
  }
}
