import 'package:flutter/material.dart';

import '../../../config/assets.dart';
import '../../core/widgets/custom_buttom.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 8,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Buscar Ativo ou Local',
            ),
          ),
          Row(
            spacing: 8,
            children: [
              CustomButtom(
                title: 'Sensor de Energia',
                iconPath: Assets.bolt,
              ),
              CustomButtom(
                title: 'Crítico',
                iconPath: Assets.critical,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
