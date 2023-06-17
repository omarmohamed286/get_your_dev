import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import 'widgets/clickable_text.dart';
import 'widgets/custom_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel? userModel;

  @override
  void initState() {
    BlocProvider.of<UserDataCubit>(context).getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'الصفحة الرئيسية'),
      drawer: const CustomDrawer(),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is CurrentUserDataSuccess) {
            userModel = BlocProvider.of<UserDataCubit>(context).currentUser;
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أهلاً بك يا ${userModel!.username}',
                      style: AppStyles.textStyle24,
                    ),
                    const SizedBox(height: 5),
                    const Text('يمكنك عرض نفسك كـ مطور الآن'),
                    const SizedBox(height: 10),
                    ClickableText(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRouter.kAddDeveloperView);
                      },
                      text: 'اعرض نفسك كـ مطور',
                    )
                  ],
                ),
              ),
            );
          } else if (state is CurrentUserDataFailure) {
            return Center(
              child: Text(state.errMessage),
            );
          } else {
            return const CustomLoadingIndicator();
          }
        },
      ),
    );
  }
}
