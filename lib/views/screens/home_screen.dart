import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/add_developer_screen.dart';
import 'package:get_your_dev/views/widgets/custom_drawer.dart';
import '../../app/utils/helpers/app_bar_helper.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'الصفحة الرئيسية'),
      drawer: const CustomDrawer(),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<UserDataCubit>(context);
          return state is UserDataLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: EdgeInsets.all(24.h),
                  children: [
                    Text(
                      'أهلاً بك يا ${cubit.userModel!.username}',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Row(
                      children: [
                        const Text('يمكنك عرض نفسك كـ مطور الآن'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AddDeveloperScreen.id);
                            },
                            child: const Text('اعرض نفسك كـ مطور')),
                      ],
                    )
                  ],
                );
        },
      ),
    );
  }
}
