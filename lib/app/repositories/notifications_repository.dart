import 'package:flutter/material.dart';
abstract class NotificationsRepository {
  Future<void> onNotification(VoidCallback onNotification);
}
