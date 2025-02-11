import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_view_app/config/assets.dart';
import 'package:tree_view_app/ui/core/widgets/location_widget.dart';

import '../../../domain/models/component.dart';
import '../../../domain/models/location.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/component_widget.dart';
import '../view_models/asset_viewmodel.dart';
import 'content.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  final assetViewModel = GetIt.instance<AssetViewModel>();

  late final Map data;
  late final String companieId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    companieId = data['id'];
    assetViewModel.getLocations.execute(companieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Content(),
            Divider(color: AppColors.grey80),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListenableBuilder(
                listenable: assetViewModel.getLocations,
                builder: (context, child) {
                  return ListenableBuilder(
                    listenable: assetViewModel,
                    builder: (context, _) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: assetViewModel.items.length,
                        itemBuilder: (context, index) {
                          final item = assetViewModel.items[index];

                          if (item is Location) {
                            final location = item;

                            return LocationWidget(
                              title: location.name,
                              subLocations: [],
                              components: item.components
                                  .map(
                                    (e) => ComponentWidget(
                                      title: e.name,
                                      status: e.status,
                                    ),
                                  )
                                  .toList(),
                            );
                          }

                          if (item is Component) {
                            final component = item;

                            return ComponentWidget(
                              title: component.name,
                              status: component.status,
                            );
                          }

                          return SizedBox.shrink();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
