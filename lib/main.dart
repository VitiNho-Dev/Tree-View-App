import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_view_app/data/services/client.dart';

import 'data/repositories/companies_repository.dart';
import 'data/repositories/companies_repository_client.dart';
import 'ui/core/themes/theme.dart';
import 'ui/home/view_models/home_view_model.dart';
import 'ui/home/widgets/home_screen.dart';
import 'utils/http_client.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerFactory<HttpClient>(() => DioHttp(Dio()));
  getIt.registerFactory(() => Client(httpClient: getIt()));
  getIt.registerFactory<CompaniesRepository>(
    () => CompaniesRepositoryClient(client: getIt()),
  );
  getIt.registerSingleton(
    HomeViewModel(companiesRepository: getIt()),
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
      },
    );
  }
}
