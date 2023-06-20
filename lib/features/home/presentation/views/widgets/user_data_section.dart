import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import 'clickable_text.dart';

class UserDataSection extends StatefulWidget {
  const UserDataSection({super.key});

  @override
  State<UserDataSection> createState() => _UserDataSectionState();
}

class _UserDataSectionState extends State<UserDataSection> {
  
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is CurrentUserDataFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else {
          userModel = BlocProvider.of<UserDataCubit>(context).currentUser;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أهلاً بك يا ${userModel!.username}',
                style: AppStyles.textStyle24,
              ),
              const SizedBox(height: 5),
              returnWidgetBasedOnUserRole(
                  context: context, role: userModel!.role),
            ],
          );
        }
      },
    );
  }

  Widget returnWidgetBasedOnUserRole(
      {required String role, required BuildContext context}) {
    if (role == 'مطور') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('يمكنك عرض نفسك كـ مطور الآن'),
          const SizedBox(height: 10),
          ClickableText(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.kAddDeveloperView);
            },
            text: 'اعرض نفسك كـ مطور',
          )
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
