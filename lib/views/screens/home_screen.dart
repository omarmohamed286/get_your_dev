import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/helpers/dialog_helper.dart';
import 'package:get_your_dev/models/developer_model.dart';
import 'package:get_your_dev/view_models/developer_data_cubit/developer_data_cubit.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/add_developer_screen.dart';
import 'package:get_your_dev/views/widgets/custom_drawer.dart';
import '../../app/utils/helpers/app_bar_helper.dart';
import '../widgets/clickable_text.dart';
import '../widgets/developer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<UserDataCubit>(context).getUser();
    BlocProvider.of<DeveloperDataCubit>(context).getDevelopers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DeveloperModel> devList =
        BlocProvider.of<DeveloperDataCubit>(context).developersList;
    DeveloperDataState developerCubitState =
        context.select((DeveloperDataCubit cubit) => cubit.state);
    UserDataCubit userCubit = BlocProvider.of<UserDataCubit>(context);
    return Scaffold(
      appBar: getAppBar(title: 'الصفحة الرئيسية'),
      drawer: const CustomDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          bool pop = false;
          customInfoDialog(
              context: context,
              title: 'هل أنت متأكد',
              description: 'هل أنت متأكد أنك تريد مغادرة التطبيق؟',
              onOkPress: () {
                pop = true;
                SystemNavigator.pop();
              }).show();
          return pop;
        },
        child: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            return state is UserDataLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: EdgeInsets.all(24.h),
                    children: [
                      Text(
                        'أهلاً بك يا ${userCubit.userModel!.username}',
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      SizedBox(height: 10.h),
                      returnWidgetBasedOnUserRole(
                          context: context, role: userCubit.userModel!.role),
                      SizedBox(height: 18.h),
                      Text(
                        'أخر المطورين',
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      SizedBox(height: 5.h),
                      developerCubitState is DeveloperDataLoading
                          ? const Align(child: CircularProgressIndicator())
                          : SizedBox(
                              height: 370.h,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    decelerationRate:
                                        ScrollDecelerationRate.fast),
                                shrinkWrap: true,
                                itemCount: devList.length,
                                itemBuilder: (context, index) {
                                  return DeveloperCard(
                                    developerModel: devList[index],
                                  );
                                },
                              ),
                            )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

Widget returnWidgetBasedOnUserRole(
    {required String role, required BuildContext context}) {
  if (role == 'مطور') {
    return Column(
      children: [
        const Text('يمكنك عرض نفسك كـ مطور الآن'),
        SizedBox(height: 5.h),
        ClickableText(
          onTap: () {
            Navigator.pushNamed(context, AddDeveloperScreen.id);
          },
          text: 'اعرض نفسك كـ مطور',
        )
      ],
    );
  }
  return const SizedBox.shrink();
}
