import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/custom_snack_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/features/home/presentation/views/widgets/accepted_developer_widget.dart';
import 'package:get_your_dev/features/home/presentation/views/widgets/rejected_developer_widget.dart';
import '../../../../core/utils/custom_app_bar.dart';
import 'widgets/new_developer_widget.dart';
import 'widgets/pending_developer_widget.dart';

class AddDeveloperView extends StatefulWidget {
  const AddDeveloperView({super.key});

  @override
  State<AddDeveloperView> createState() => _AddDeveloperViewState();
}

class _AddDeveloperViewState extends State<AddDeveloperView> {
  @override
  void initState() {
    BlocProvider.of<UserDataCubit>(context).getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'معلومات المطور'),
      body: BlocConsumer<UserDataCubit, UserDataState>(
        listener: (context, state) {
          if (state is UpdateUserDataFailure) {
            Navigator.pop(context);
            showErrorSnackBar(
                context: context,
                content: 'فشل إرسال الطلب، يرجي المحاولة مرة أخري');
          }
        },
        builder: (context, state) {
          UserModel? developer =
              BlocProvider.of<UserDataCubit>(context).currentUser;
          if (state is CurrentUserDataLoading) {
            return const CustomLoadingIndicator();
          } else {
            if (developer!.status == null) {
              return const NewDeveloperWidget();
            } else if (developer.status == 'pending') {
              return const PendingDeveloperWidget();
            } else if (developer.status == 'accepted') {
              return AcceptedDeveloperWidget(developer: developer);
            } else if (developer.status == 'rejected') {
              return const RejectedDeveloperWidget();
            }
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
