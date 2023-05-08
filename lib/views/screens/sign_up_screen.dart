import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/constants.dart';
import 'package:get_your_dev/app/utils/helpers/dialog_helper.dart';
import 'package:get_your_dev/app/utils/helpers/snack_bar_helper.dart';
import 'package:get_your_dev/models/user_model.dart';
import 'package:get_your_dev/view_models/drop_down_cubit/drop_down_cubit.dart';
import 'package:get_your_dev/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:get_your_dev/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:get_your_dev/views/screens/home_screen.dart';
import 'package:get_your_dev/views/screens/sign_in_screen.dart';
import 'package:get_your_dev/views/widgets/custom_text_field.dart';
import '../../app/utils/services/auth_service.dart';
import '../../app/utils/services/cache_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const id = 'signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formsKey = GlobalKey<FormState>();

  String? username;

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit(AuthService.instance())),
        BlocProvider(create: (context) => DropDownCubit())
      ],
      child: Scaffold(
        body: Form(
          key: formsKey,
          child: Center(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(12.w),
                children: [
                  SizedBox(height: 20.h),
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: 10.h),
                  Text(
                    "إنشاء حساب",
                    style:
                        TextStyle(fontSize: 36.sp, color: Constants.blackColor),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    labelText: 'اسم المستخدم',
                    keyword: 'username',
                    onSaved: (value) {
                      username = value;
                    },
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
                      Text(
                        'أنا: ',
                        style: TextStyle(
                            fontSize: 32.sp, color: Constants.blackColor),
                      ),
                      SizedBox(width: 30.w),
                      const CustomDropDownButton(
                        keyword: 'signup',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('هل لديك حساب بالفعل؟'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignInScreen.id);
                          },
                          child: const Text("تسجيل الدخول"))
                    ],
                  ),
                  SizedBox(height: 10.h),
                  BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpFailure) {
                        customErrorDialog(
                                context: context,
                                description: state.errorMessage)
                            .show();
                      } else if (state is SignUpSuccess) {
                        BlocProvider.of<UserDataCubit>(context).addUser(
                          UserModel(
                              image:
                                  'https://i.pinimg.com/originals/71/f3/51/71f3519243d136361d81df71724c60a0.png',
                              username: username!.trim(),
                              email: email!.trim(),
                              role: BlocProvider.of<DropDownCubit>(context)
                                  .signupDropDownValue),
                        );
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                        CacheService.setBool(Constants.isLogedKey, true);
                        showSnackBar(
                            context: context,
                            content: 'تم إنشاء الحساب بنجاح',
                            backgroundColor: Colors.green);
                      }
                    },
                    builder: (context, state) {
                      return state is SignUpLoading
                          ? const Align(child: CircularProgressIndicator())
                          : CustomButton(
                              text: 'إنشاء حساب',
                              onPressed: () async {
                                if (formsKey.currentState!.validate()) {
                                  formsKey.currentState!.save();
                                  await BlocProvider.of<SignUpCubit>(context)
                                      .signUp(email!, password!);
                                }
                              },
                            );
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
