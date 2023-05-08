import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/developer_model.dart';
import '../../models/user_model.dart';
import '../../view_models/developer_data_cubit/developer_data_cubit.dart';
import '../../view_models/drop_down_cubit/drop_down_cubit.dart';
import '../../view_models/user_data_cubit/user_data_cubit.dart';
import '../screens/user_informations_screen.dart';
import 'clickable_text.dart';
import 'custom_button.dart';
import 'custom_drop_down_button.dart';
import 'custom_text_field.dart';

class NewDeveloperForm extends StatefulWidget {
  const NewDeveloperForm({super.key, required this.state});

  final DeveloperDataState state;

  @override
  State<NewDeveloperForm> createState() => _NewDeveloperFormState();
}

class _NewDeveloperFormState extends State<NewDeveloperForm> {
  String? field;

  String? shortDesc;

  String? longDesc;

  final GlobalKey<FormState> formsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = BlocProvider.of<UserDataCubit>(context).userModel;

    return Form(
      key: formsKey,
      child: ListView(
        padding: EdgeInsets.all(10.h),
        children: [
          SizedBox(height: 24.h),
          const Center(
              child:
                  Text('قم بلمئ هذه البيانات ليتمكن الأشخاص من معرفة مهاراتك')),
          SizedBox(height: 24.h),
          Text(
            'تخصص المطور',
            style: TextStyle(fontSize: 16.sp),
          ),
          const CustomDropDownButton(keyword: 'dev'),
          SizedBox(height: 15.h),
          Text(
            'نبذه قصيرة عن المطور',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          CustomTextField(
            maxLength: 50,
            onChanged: (value) {
              shortDesc = value;
            },
          ),
          SizedBox(height: 15.h),
          Text(
            'وصف كامل عن المطور (قم بوصف جميع مهاراتك وخبراتك)',
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 5.h),
          CustomTextField(
            maxLines: 4,
            keyword: 'dev',
            onChanged: (value) {
              longDesc = value;
            },
          ),
          SizedBox(height: 10.h),
          const Text('تنبيه: سوف يظهر إسمك والصورة الخاصة بك للعملاء'),
          SizedBox(height: 10.h),
          ClickableText(
            onTap: () {
              Navigator.pushNamed(context, UserInfromationsScreen.id);
            },
            text: 'إذهب لصفحة معلومات المستخدم لتعديلهما',
          ),
          SizedBox(height: 10.h),
          widget.state is DeveloperAddingLoading
              ? const LinearProgressIndicator()
              : CustomButton(
                  text: 'تأكيد المعلومات',
                  onPressed: () {
                    if (formsKey.currentState!.validate()) {
                      formsKey.currentState!.save();
                      BlocProvider.of<DeveloperDataCubit>(context).addDeveloper(
                          DeveloperModel(
                              userModel!.image,
                              userModel.username,
                              BlocProvider.of<DropDownCubit>(context)
                                  .developerDropDownValue,
                              shortDesc!,
                              longDesc!,
                              'pending'));
                    }
                  })
        ],
      ),
    );
  }
}
