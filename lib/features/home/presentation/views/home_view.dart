import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_app_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/developers_list_view.dart';
import 'widgets/user_data_section.dart';

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
    BlocProvider.of<UserDataCubit>(context).getAcceptedDevelopers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'الصفحة الرئيسية'),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              return state is CurrentUserDataLoading ||
                      state is DevelopersDataLoading
                  ? const CustomLoadingIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UserDataSection(),
                        const SizedBox(height: 24),
                        Text(
                          'أخر المطورين',
                          style: AppStyles.textStyle24,
                        ),
                        const SizedBox(height: 5),
                        const DevelopersListView()
                      ],
                    );
            },
          ),
        ));
  }
}
