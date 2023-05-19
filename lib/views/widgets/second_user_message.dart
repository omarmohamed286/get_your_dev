import 'package:flutter/material.dart';

import '../../app/utils/constants.dart';
import '../../models/message_model.dart';

class SecondUserMessage extends StatelessWidget {
  const SecondUserMessage({super.key, required this.messageModel});
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32))),
        child: Text(
          messageModel.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
