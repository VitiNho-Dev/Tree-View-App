import 'package:flutter/material.dart';
import 'package:tree_view_app/design_system/custom_text_styles.dart';

import '../../../design_system/colors.dart';
import '../../../design_system/images_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImagesPath.logoTractian),
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
                color: CustomColors.secondary,
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
                    Image.asset('assets/icons/vector.png'),
                    Text(
                      "Jaguar Unit",
                      style: CustomTextStyles.title,
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
