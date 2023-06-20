import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/core/constants.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/home/presentation/view_model/developer_drop_down_button.dart/developer_drop_down_button_cubit.dart';
import '../../../../../core/utils/custom_snack_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../view_model/user_data_cubit/user_data_cubit.dart';
import 'clickable_text.dart';
import 'custom_text_field.dart';
import 'developer_drop_down_button.dart';

class NewDeveloperWidget extends StatefulWidget {
  const NewDeveloperWidget({super.key});

  @override
  State<NewDeveloperWidget> createState() => _NewDeveloperWidgetState();
}

class _NewDeveloperWidgetState extends State<NewDeveloperWidget> {
  String? shortDesc;

  String? longDesc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeveloperDropDownButtonCubit(),
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 24),
          Center(
              child: Text(
            'قم بلمئ هذه البيانات ليتمكن الأشخاص من معرفة مهاراتك',
            style: AppStyles.textStyle18.copyWith(color: kBlackColor),
          )),
          const SizedBox(height: 24),
          Text(
            'تخصص المطور',
            style: AppStyles.textStyle24,
          ),
          const DeveloperDropDownButton(),
          const SizedBox(height: 15),
          Text(
            'نبذه قصيرة عن المطور',
            style: AppStyles.textStyle24,
          ),
          const SizedBox(height: 5),
          CustomTextField(
            maxLength: 50,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              shortDesc = value;
            },
          ),
          const SizedBox(height: 15),
          Text(
            'وصف كامل عن المطور (قم بوصف جميع مهاراتك وخبراتك)',
            style: AppStyles.textStyle24,
          ),
          SizedBox(height: 5.h),
          CustomTextField(
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            onChanged: (value) {
              longDesc = value;
            },
          ),
          SizedBox(height: 10.h),
          const Text('تنبيه: سوف يظهر إسمك والصورة الخاصة بك للعملاء'),
          SizedBox(height: 10.h),
          ClickableText(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.kUserInformationsView);
            },
            text: 'إذهب لصفحة معلومات المستخدم لتعديلهما',
          ),
          SizedBox(height: 10.h),
          BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              return state is UpdateUserDataLoading
                  ? const CustomLoadingIndicator()
                  : CustomButton(
                      text: 'تأكيد المعلومات',
                      onPressed: () {
                        if (shortDesc != null && longDesc != null) {
                          updateUserDataInDatabase(context);
                        }
                      });
            },
          )
        ],
      ),
    );
  }

  void updateUserDataInDatabase(BuildContext context) {
    var cubit = BlocProvider.of<UserDataCubit>(context);
    Future.wait([
      cubit.updateUserData(key: 'shortDescription', value: shortDesc!),
      cubit.updateUserData(key: 'longDescription', value: longDesc!),
      cubit.updateUserData(
          key: 'field',
          value: BlocProvider.of<DeveloperDropDownButtonCubit>(context)
              .developerDropDownValue),
      cubit.updateUserData(key: 'status', value: 'pending'),
    ]).then(
      (value) {
        Navigator.pushReplacementNamed(context, AppRouter.kHomeView);
        cubit.getCurrentUserData();
        showSuccessSnackBar(
            context: context,
            content:
                'تم إرسال طلبك بنجاح، سوف يتم مراجعته وإرسال إشعار لك فور القبول');
      },
    );
  }
}
