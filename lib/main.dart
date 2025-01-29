import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_view_app/data/services/client.dart';
import 'package:tree_view_app/ui/asset/view_models/asset_viewmodel.dart';
import 'package:tree_view_app/ui/asset/widgets/asset_screen.dart';

import 'data/repositories/companies_repository.dart';
import 'data/repositories/companies_repository_client.dart';
import 'ui/core/themes/theme.dart';
import 'ui/home/view_models/home_viewmodel.dart';
import 'ui/home/widgets/home_screen.dart';
import 'utils/http_client.dart';

GetIt getIt = GetIt.instance;

void main() {
  // Http
  getIt.registerFactory<HttpClient>(() => DioHttp(Dio()));

  // Client
  getIt.registerFactory(() => Client(httpClient: getIt()));

  // Repository
  getIt.registerSingleton<CompaniesRepository>(
    CompaniesRepositoryClient(client: getIt()),
  );

  // ViewModel
  getIt.registerSingleton(
    HomeViewModel(companiesRepository: getIt()),
  );
  getIt.registerSingleton(
    AssetViewModel(companiesRepository: getIt()),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/asset': (context) => AssetScreen(),
      },
    );
  }
}
