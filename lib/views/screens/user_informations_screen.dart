import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/widgets/choose_image_widget.dart';
import '../../models/user_model.dart';

class UserInfromationsScreen extends StatelessWidget {
  const UserInfromationsScreen({super.key});

  static const id = 'userInformationsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'معلومات المستخدم'),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDataFailure) {
            return const Center(
                child: Text("حدث خطأ غير متوقع، حاول مرة أخري"));
          }
          UserModel? userModel =
              BlocProvider.of<UserDataCubit>(context).userModel;
          return ListView(padding: EdgeInsets.all(12.h), children: [
            SizedBox(height: 30.h),
            ChooseImageWiget(
              userModel: userModel!,
            ),
            SizedBox(height: 30.h),
            ListTile(
              title: const Text('اسم المستخدم'),
              subtitle: Text(userModel.username),
            ),
            SizedBox(height: 30.h),
            ListTile(
              title: const Text('البريد الإلكتروني'),
              subtitle: Text(userModel.email),
            ),
            SizedBox(height: 30.h),
            ListTile(
              title: const Text('الدور'),
              subtitle: Text(userModel.role == 'أبحث عن مطور'
                  ? 'يبحث عن مطور'
                  : userModel.role),
            ),
          ]);
        },
      ),
    );
  }
}
