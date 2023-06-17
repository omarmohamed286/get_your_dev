import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/app_styles.dart';
import 'package:get_your_dev/core/utils/custom_snack_bar.dart';
import 'package:get_your_dev/core/utils/services/cache_service.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import '../view_model/auth_cubit/auth_cubit.dart';
import '../view_model/drop_down_button_cubit/drop_down_button_cubit.dart';
import 'widgets/custom_drop_down_button.dart';
import 'widgets/custom_password_text_form_field.dart';
import 'widgets/custom_text_form_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? username, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 10),
                  Text(
                    "إنشاء حساب",
                    style: AppStyles.textStyle32,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'اسم المستخدم',
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'البريد الإلكتروني',
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordTextFormField(
                    labelText: 'كلمة المرور',
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'أنا: ',
                        style: AppStyles.textStyle32,
                      ),
                      const SizedBox(width: 30),
                      const CustomDropDownButton(),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('هل لديك حساب بالفعل؟'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, AppRouter.kSigninView);
                          },
                          child: const Text("تسجيل الدخول"))
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        showSuccessSnackBar(
                            context: context, content: 'تم إنشاء الحساب بنجاح');
                        addUserDataToDatabase(context);
                        CacheService.setBool(kIsLogedKey, true);
                        Navigator.pushReplacementNamed(
                            context, AppRouter.kHomeView);
                      } else if (state is AuthFailure) {
                        showErrorSnackBar(
                            context: context, content: state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CustomLoadingIndicator();
                      }
                      return CustomButton(
                        text: 'إنشاء حساب',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BlocProvider.of<AuthCubit>(context)
                                .signupUser(email: email!, password: password!);
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addUserDataToDatabase(BuildContext context) {
    String userRole =
        BlocProvider.of<DropDownButtonCubit>(context).signupDropDownValue;
    BlocProvider.of<UserDataCubit>(context).addUserData(
        userModel: UserModel(
            username: username!,
            email: email!,
            image:
                'https://i.pinimg.com/originals/71/f3/51/71f3519243d136361d81df71724c60a0.png',
            role: userRole,
            field: null,
            shortDescription: null,
            longDescription: null,
            status: null));
  }
}
