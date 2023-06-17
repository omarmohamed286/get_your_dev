abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);

  factory AuthFailure.fromSigninError({required String eCode}) {
    if (eCode == 'user-not-found') {
      return const AuthFailure(
          'لا يوجد بريد مسجل بهذا الحساب، حاول إنشاء حساب');
    } else if (eCode == 'wrong-password') {
      return const AuthFailure('كلمة المرور التي أدخلتها غير صحيحة');
    } else {
      return const AuthFailure('حدث خطأ غير متوقع، برجاء المحاولة مرة أخري');
    }
  }

  factory AuthFailure.fromSignupError({required String eCode}) {
    if (eCode == 'weak-password') {
      return const AuthFailure('كلمة المرور التي أدخلتها ضعيفة');
    } else if (eCode == 'email-already-in-use') {
      return const AuthFailure('البريد الإلكتروني الذي ادخلته مستخدم بالفعل');
    } else {
      return const AuthFailure('حدث خطأ غير متوقع، برجاء المحاولة مرة أخري');
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);
}
