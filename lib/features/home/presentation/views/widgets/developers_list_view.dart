import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/constants.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import '../../../../../core/models/user_model.dart';
import '../../view_model/user_data_cubit/user_data_cubit.dart';
import 'developer_card.dart';

class DevelopersListView extends StatelessWidget {
  const DevelopersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is DevelopersDataFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else {
          List<UserModel> developersList =
              BlocProvider.of<UserDataCubit>(context).developersList;
          if (developersList.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد مطورين في هذا المجال حالياً',
                style: AppStyles.textStyle18.copyWith(color: kBlackColor),
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              itemCount: developersList.length,
              itemBuilder: (context, index) {
                return DeveloperCard(developer: developersList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
