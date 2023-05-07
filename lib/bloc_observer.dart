import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    print("The created bloc is: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print("The closed bloc is: $bloc");
    super.onClose(bloc);
  }
}
