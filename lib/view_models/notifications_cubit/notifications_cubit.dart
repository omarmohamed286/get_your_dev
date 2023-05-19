import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_your_dev/app/repositories/notifications_repository.dart';
import 'package:meta/meta.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.notify) : super(NotificationsInitial());
  NotificationsRepository notify;

  Future<void> onNotification(VoidCallback onNotification) async {
    await notify.onNotification(onNotification);
  }
}
