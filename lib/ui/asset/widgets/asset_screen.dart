import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_view_app/config/assets.dart';

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
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: assetViewModel.locations.length,
                        itemBuilder: (context, index) {
                          final location = assetViewModel.locations[index];
                          return _buildTile(
                            title: location.name,
                            icon: Assets.location,
                          );
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

  Widget _buildTile({
    required String title,
    required String icon,
    List<Widget>? children,
  }) {
    return ExpansionTile(
      showTrailingIcon: false,
      leading: Icon(Icons.keyboard_arrow_down),
      title: Row(
        children: [
          Image.asset(icon),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.black100),
          ),
        ],
      ),
      children: children ?? [],
    );
  }
}
