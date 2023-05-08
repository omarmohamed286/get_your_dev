import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_your_dev/app/utils/helpers/app_bar_helper.dart';
import 'package:get_your_dev/app/utils/helpers/snack_bar_helper.dart';
import 'package:get_your_dev/models/developer_model.dart';
import 'package:get_your_dev/view_models/developer_data_cubit/developer_data_cubit.dart';
import 'package:get_your_dev/view_models/drop_down_cubit/drop_down_cubit.dart';
import '../widgets/accepted_developer_widget.dart';
import '../widgets/new_developer_form.dart';

class AddDeveloperScreen extends StatefulWidget {
  const AddDeveloperScreen({super.key});

  static const id = 'addDeveloperScreen';

  @override
  State<AddDeveloperScreen> createState() => _AddDeveloperScreenState();
}

class _AddDeveloperScreenState extends State<AddDeveloperScreen> {
  @override
  void initState() {
    BlocProvider.of<DeveloperDataCubit>(context).getCurrentDeveloper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeveloperModel? developerModel;
    return BlocProvider(
      create: (context) => DropDownCubit(),
      child: Scaffold(
        appBar: getAppBar(title: 'إضافة مطور'),
        body: BlocConsumer<DeveloperDataCubit, DeveloperDataState>(
          listener: (context, state) {
            if (state is DeveloperAddingSuccess) {
              Phoenix.rebirth(context);
              showSnackBar(
                  context: context,
                  content:
                      'تم إرسال طلبك بنجاح، سوف يتم مراجعته وإرسال إشعار لك فور القبول',
                  backgroundColor: Colors.green,
                  seconds: 5);
            }
            if (state is DeveloperAddingFailure) {
              showSnackBar(
                  context: context,
                  content: 'فشل إرسال الطلب، يرجي المحاولة مرة أخري',
                  backgroundColor: Colors.red);
            }
            if (state is CurrentDeveloperSuccess) {
              developerModel =
                  BlocProvider.of<DeveloperDataCubit>(context).developerModel;
            }
          },
          builder: (context, state) {
            if (state is CurrentDeveloperLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (developerModel == null) {
              return NewDeveloperForm(
                state: state,
              );
            }
            if (developerModel!.isAccepted == 'true') {
              return AcceptedDeveloperWidget(developerModel: developerModel!);
            }
            if (developerModel!.isAccepted == 'pending') {
              return const Center(
                child: Text("لقد أرسلت طلباً بالفعل، طلبك الأن قيد المراجعة"),
              );
            }
            if (developerModel!.isAccepted == 'rejected') {
              return const Center(
                child: Text('لقد تم رفض طلبك'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
