import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/view_models/sign_in_cubit/sign_in_cubit.dart';
import 'package:get_your_dev/views/screens/reset_password_screen.dart';
import '../../app/utils/constants.dart';
import '../../app/utils/helpers/dialog_helper.dart';
import '../../app/utils/helpers/snack_bar_helper.dart';
import '../../app/utils/services/auth_service.dart';
import '../../app/utils/services/cache_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String id = 'signIn';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formsKey = GlobalKey<FormState>();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(AuthService.instance()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.w),
          child: Form(
              key: formsKey,
              child: ListView(children: [
                SizedBox(height: 50.h),
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 10.h),
                Text(
                  'تسجيل الدخول',
                  style:
                      TextStyle(fontSize: 36.sp, color: Constants.blackColor),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelText: 'البريد الإلكتروني',
                  keyword: 'email',
                  onSaved: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelText: 'كلمة المرور',
                  keyword: 'password',
                  onSaved: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ResetPasswordScreen.id);
                        },
                        child: const Text('هل نسيت كلمة المرور؟')),
                  ],
                ),
                Row(
                  children: [
                    const Text('لا تملك حساب؟'),
                    TextButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          }
                        },
                        child: const Text('إنشاء حساب'))
                  ],
                ),
                SizedBox(height: 10.h),
                BlocConsumer<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state is SignInFailure) {
                      customErrorDialog(
                              context: context, description: state.errorMessage)
                          .show();
                    } else if (state is SignInSuccess) {
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                      CacheService.setBool(Constants.isLogedKey, true);
                      showSnackBar(
                          context: context,
                          content: 'تم تسجيل الدخول بنجاح',
                          backgroundColor: Colors.green);
                    }
                  },
                  builder: (context, state) {
                    return state is SignInLoading
                        ? const Align(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'تسجيل الدخول',
                            onPressed: () async {
                              if (formsKey.currentState!.validate()) {
                                formsKey.currentState!.save();
                                await BlocProvider.of<SignInCubit>(context)
                                    .signIn(email!, password!);
                              }
                            },
                          );
                  },
                ),
              ])),
        ),
      ),
    );
  }
}
