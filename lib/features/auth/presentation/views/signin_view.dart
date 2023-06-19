import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/custom_snack_bar.dart';
import 'package:get_your_dev/core/widgets/custom_loading_indicator.dart';
import 'package:get_your_dev/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:get_your_dev/features/home/presentation/views/widgets/clickable_text.dart';
import '../../../../core/constants.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/services/cache_service.dart';
import '../../../../core/widgets/custom_button.dart';
import 'widgets/custom_password_text_form_field.dart';
import 'widgets/custom_text_form_field.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email, password;

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
                    'تسجيل الدخول',
                    style: AppStyles.textStyle32,
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
                  ClickableText(
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.kResetPasswordView);
                      },
                      text: 'هل نسيت كلمة المرور؟'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('لا تملك حساب؟'),
                      const SizedBox(width: 10),
                      ClickableText(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pushNamed(
                                  context, AppRouter.kSignupView);
                            }
                          },
                          text: 'إنشاء حساب')
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        showSuccessSnackBar(
                            context: context, content: 'تم تسجيل الدخول بنجاح');
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
                        text: 'تسجيل الدخول',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            BlocProvider.of<AuthCubit>(context)
                                .signinUser(email: email!, password: password!);
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
}
