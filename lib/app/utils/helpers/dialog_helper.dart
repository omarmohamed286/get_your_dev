import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog customErrorDialog(
        {required BuildContext context, required String description}) =>
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: '!حدث خطأ',
      desc: getDescriptionInArabic(description),
      btnOkOnPress: () {},
    );

AwesomeDialog customInfoDialog({
  required BuildContext context,
  required String title,
  required String description,
  required VoidCallback onOkPress,
}) =>
    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.scale,
        title: title,
        desc: description,
        btnOkOnPress: () {},
        btnCancelOnPress: onOkPress,
        btnOkText: 'إلغاء',
        btnCancelText: 'نعم');

// simple function that returns a specific error message depending on firebase error
String getDescriptionInArabic(String description) {
  if (description.contains('email-already-in-use')) {
    return 'هذا الحساب مسجل بالفعل، حاول تسجيل الدخول';
  } else if (description.contains('user-not-found')) {
    return 'لا يوجد حساب مسجل لهذا المستخدم، حاول إنشاء حساب جديد';
  } else if (description.contains('weak-password')) {
    return 'كلمة مرور ضعيفة، يجب ألا تقل كلمة المرور عن 6 أحرف';
  } else if (description.contains('wrong-password')) {
    return 'كلمة مرور التي أدخلتها غير صحيحة، يرجي إدخال كلمة مرور صحيحة';
  }
  return 'حدث خطأ غير متوقع، يرجي المحاولة مرة أخري';
}
