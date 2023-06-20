import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/features/home/presentation/views/widgets/new_developer_widget.dart';
import 'package:get_your_dev/core/constants.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'developer_card.dart';

class AcceptedDeveloperWidget extends StatelessWidget {
  const AcceptedDeveloperWidget({super.key, required this.developer});

  final UserModel developer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تم قبول طلبك وسوف يظهر للعملاء بهذا الشكل:',
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(height: 10.h),
              DeveloperCard(developer: developer),
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
      ),
    );
  }
}
