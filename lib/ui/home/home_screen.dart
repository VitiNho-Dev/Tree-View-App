import 'package:flutter/material.dart';

import '../../config/assets.dart';
import '../core/themes/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.logoTractian),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, top: 30, right: 22),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
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
                      "Jaguar Unit",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
