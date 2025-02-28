import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/models/asset.dart';
import '../../../domain/models/location.dart';
import '../../core/themes/colors.dart';
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
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: assetViewModel.items.map(
                          (item) {
                            if (item is Location) {
                              return _buildLocationTile(item);
                            }
                            return SizedBox.shrink();
                          },
                        ).toList(),
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

  Widget _buildLocationTile(Location location) {
    return ExpansionTile(
      title: Text(location.name),
      children: [
        ...location.subLocations.map((subLocation) {
          return _buildLocationTile(subLocation);
        }),
        ...location.assets.map((asset) {
          return _buildAssetTile(asset);
        }),
      ],
    );
  }

  Widget _buildAssetTile(Asset asset) {
    return ExpansionTile(
      title: Text(asset.name),
      children: [
        ...asset.subAssets.map((subAsset) {
          return _buildSubAssetTile(subAsset);
        }),
        ...asset.components.map((component) {
          return ListTile(
            title: Text(component.name),
          );
        }),
      ],
    );
  }

  Widget _buildSubAssetTile(Asset subAsset) {
    return ExpansionTile(
      title: Text(subAsset.name),
      children: subAsset.components.map((component) {
        return ListTile(
          title: Text(component.name),
        );
      }).toList(),
    );
  }
}
