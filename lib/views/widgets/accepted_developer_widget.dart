import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/models/developer_model.dart';
import 'package:get_your_dev/views/widgets/developer_card.dart';
import '../../view_models/drop_down_cubit/drop_down_cubit.dart';
import 'custom_button.dart';
import 'new_developer_form.dart';

class AcceptedDeveloperWidget extends StatelessWidget {
  const AcceptedDeveloperWidget({super.key, required this.developerModel});

  final DeveloperModel developerModel;

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
              DeveloperCard(developerModel: developerModel),
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
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: BlocProvider(
                              create: (context) => DropDownCubit(),
                              child: const NewDeveloperForm()),
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
