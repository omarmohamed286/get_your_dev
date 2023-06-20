import 'package:flutter/material.dart';

class PendingDeveloperWidget extends StatelessWidget {
  const PendingDeveloperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("لقد أرسلت طلباً بالفعل، طلبك الأن قيد المراجعة"),
    );
  }
}
