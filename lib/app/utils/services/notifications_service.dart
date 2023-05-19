import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../repositories/notifications_repository.dart';

class NotifiactionsService extends NotificationsRepository{
  
  @override
  Future<void> onNotification(VoidCallback onNotification) async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      onNotification();
    }
  }
}
