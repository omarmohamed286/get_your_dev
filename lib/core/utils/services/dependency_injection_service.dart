import 'package:get_it/get_it.dart';
import 'package:get_your_dev/core/utils/services/auth_service.dart';
import 'package:get_your_dev/core/utils/services/chat_service.dart';
import 'package:get_your_dev/core/utils/services/user_data_service.dart';
import 'package:get_your_dev/features/auth/data/repos/auth_repo_impl.dart';
import 'package:get_your_dev/features/home/data/repos/home_repo_impl.dart';

import '../../../features/chat/data/repos/chat_repo_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(AuthService()));
  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(UserDataService()));
  getIt.registerSingleton<ChatRepoImpl>(ChatRepoImpl(ChatService()));
}
