import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_your_dev/app/utils/constants.dart';
import 'package:get_your_dev/app/utils/services/cache_service.dart';
import 'package:get_your_dev/bloc_observer.dart';
import 'package:get_your_dev/views/screens/home_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/config/app_routes.dart';
import 'app/config/app_themes.dart';
import 'app/utils/services/user_data_service.dart';
import 'view_models/user_data_cubit/user_data_cubit.dart';
import 'views/screens/sign_up_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheService.initPrefs();
  Bloc.observer = AppBlocObserver();
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
        CacheService.getBool(Constants.isLogedKey);
        return BlocProvider(
          create: (context) => UserDataCubit(UserDataService.instance()),
          child: MaterialApp(
              builder: (context, child) => Directionality(
                  textDirection: TextDirection.rtl, child: child!),
              debugShowCheckedModeBanner: false,
              title: Constants.appTitle,
              theme: getAppTheme(),
              initialRoute: CacheService.isLoged ?? false
                  ? HomeScreen.id
                  : SignUpScreen.id,
              routes: AppRoutes.routes),
        );
      },
    );
  }
}
