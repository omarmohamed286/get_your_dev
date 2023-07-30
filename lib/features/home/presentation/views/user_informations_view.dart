import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:get_your_dev/core/utils/custom_snack_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/home/presentation/views/widgets/choose_image_widget.dart';
import '../../../../core/models/user_model.dart';
import '../view_model/user_data_cubit/user_data_cubit.dart';
import 'widgets/user_info_card.dart';

class UserInformationsView extends StatefulWidget {
  const UserInformationsView({super.key});

  @override
  State<UserInformationsView> createState() => _UserInformationsViewState();
}

class _UserInformationsViewState extends State<UserInformationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'معلومات المستخدم'),
      body: BlocConsumer<UserDataCubit, UserDataState>(
        listener: (context, state) {
          if (state is UploadUserImageFailure) {
            showErrorSnackBar(context: context, content: state.errMessage);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          UserModel? userModel =
              BlocProvider.of<UserDataCubit>(context).currentUser;
          if (state is UploadUserImageLoading) {
            return const CustomLoadingIndicator();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  ChooseImageWiget(userModel: userModel),
                  const SizedBox(height: 30),
                  UserInfoCard(
                    info: 'اسم المستخدم',
                    infoValue: userModel!.username,
                    onEditPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.kEditUsernameView,
                        arguments: userModel.username,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  UserInfoCard(
                    info: 'البريد الإلكتروني',
                    infoValue: userModel.email,
                    onEditPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.kEditEmailView,
                        arguments: userModel.email,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  UserInfoCard(
                    info: 'كلمة المرور',
                    infoValue: '',
                    onEditPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.kEditPasswordView,
                        arguments: '',
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  UserInfoCard(
                    info: 'الدور',
                    infoValue: userModel.role,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
