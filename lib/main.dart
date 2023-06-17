import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_your_dev/core/constants.dart';
import 'package:get_your_dev/core/utils/app_router.dart';
import 'package:get_your_dev/core/utils/services/dependency_injection_service.dart';
import 'package:get_your_dev/features/home/data/repos/home_repo_impl.dart';
import 'package:get_your_dev/features/home/presentation/view_model/user_data_cubit/user_data_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/utils/services/cache_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheService.initPrefs();
  setupDependencies();
  runApp(Phoenix(child: const GetYourDev()));
}

class GetYourDev extends StatelessWidget {
  const GetYourDev({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        CacheService.getBool(kIsLogedKey);
        return BlocProvider(
          create: (context) => UserDataCubit(getIt.get<HomeRepoImpl>()),
          child: MaterialApp(
            builder: (context, child) =>
                Directionality(textDirection: TextDirection.rtl, child: child!),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: GoogleFonts.tajawal().fontFamily),
            initialRoute: CacheService.isLoged ?? false
                ? AppRouter.kHomeView
                : AppRouter.kSignupView,
            routes: AppRouter.routes,
          ),
        );
      },
    );
  }
}
