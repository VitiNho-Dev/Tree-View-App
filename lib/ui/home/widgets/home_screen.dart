import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_view_app/ui/home/view_models/home_viewmodel.dart';

import '../../../config/assets.dart';
import '../../core/themes/colors.dart';

class HomeScreen extends StatelessWidget {
  final homeViewModel = GetIt.instance<HomeViewModel>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.logoTractian),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, top: 30, right: 22),
        child: ListenableBuilder(
          listenable: homeViewModel.getCompanies,
          builder: (context, child) {
            if (homeViewModel.getCompanies.running) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (homeViewModel.getCompanies.error) {
              return const Center(
                child: Text('Ocorreu um erro ao carregar as companhias!'),
              );
            }

            return child!;
          },
          child: ListenableBuilder(
            listenable: homeViewModel,
            builder: (context, _) {
              return ListView.builder(
                itemCount: homeViewModel.companies.length,
                itemBuilder: (context, index) {
                  final companie = homeViewModel.companies[index];

                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/asset',
                        arguments: {'id': companie.id},
                      );
                    },
                    child: Container(
                      height: 76,
                      margin: EdgeInsets.only(bottom: 40),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 26,
                          horizontal: 32,
                        ),
                        child: Row(
                          spacing: 16,
                          children: [
                            Image.asset(Assets.vector),
                            Text(
                              companie.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
