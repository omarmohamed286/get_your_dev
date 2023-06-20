import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/features/home/presentation/views/widgets/new_developer_widget.dart';
import '../../../../../core/widgets/custom_button.dart';

class RejectedDeveloperWidget extends StatelessWidget {
  const RejectedDeveloperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('لقد تم رفض طلبك'),
            SizedBox(height: 15.h),
            const Text('هل تريد تعديل بياناتك والتقديم مرة اخري؟'),
            SizedBox(height: 15.h),
            CustomButton(
                text: 'تعديل بياناتي',
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom)
                            .add(const EdgeInsets.only(top: 50)),
                        child: const NewDeveloperWidget(),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
