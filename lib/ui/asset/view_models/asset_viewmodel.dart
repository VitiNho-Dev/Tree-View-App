import 'package:flutter/material.dart';

import '../../../data/repositories/companies_repository.dart';
import '../../../domain/models/asset.dart';
import '../../../domain/models/component.dart';
import '../../../domain/models/location.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class AssetViewModel extends ChangeNotifier {
  final CompaniesRepository _companiesRepository;

  AssetViewModel({
    required CompaniesRepository companiesRepository,
  }) : _companiesRepository = companiesRepository {
    getLocations = Command1(_getLocations);
  }

  late final Command1<void, String> getLocations;

  var items = <Object>{};

  var _locations = <Location>[];

  Future<Result<void>> _getLocations(String id) async {
    final result = await _companiesRepository.getLocations(id);

    switch (result) {
      case Ok<List<Location>>():
        _locations = result.value;
        notifyListeners();
      case Error<List<Location>>():
        return result;
    }

    await _getAssets(id);

    return result;
  }

  var _assets = <Asset>[];

  Future<Result<List<Asset>>> _getAssets(String id) async {
    final result = await _companiesRepository.getAssets(id);

    switch (result) {
      case Ok<List<Asset>>():
        _assets = result.value;
      case Error<List<Asset>>():
        return result;
    }

    _getComponet();

    return result;
  }

  var _components = <Component>[];

  Result<List<Component>> _getComponet() {
    final result = _companiesRepository.getComponents();

    switch (result) {
      case Ok<List<Component>>():
        _components = result.value;
      case Error<List<Component>>():
        return result;
    }

    _buildHierarchy();

    return result;
  }

  /// Limpa a lista de components de itens duplicados.
  List<Component> _filterComponents() {
    List<Component> filteredComponents = _components
        .fold<Map<String, Component>>({}, (map, component) {
          map[component.id] = component;
          return map;
        })
        .values
        .toList();

    _components.clear();

    return filteredComponents;
  }

  final _componentsExternal = <Component>[];
  final _componentFromAsset = <Component>[];
  final _componentFromLocation = <Component>[];

  /// Separa os componentes que vão pertencer ao Location, ao Assets e os componentes que são externos.
  void _separateComponents(List<Component> componets) {
    for (var component in componets) {
      if (component.parentId != null) {
        _componentFromAsset.add(component);
      } else if (component.locationId != null) {
        _componentFromLocation.add(component);
      } else {
        _componentsExternal.add(component);
      }
    }

    componets.clear();
  }

  /// Atribui um component à um asset e retorna uma lista de assets com os componentes atribuidos.
  List<Asset> _assignAComponentToAnAsset() {
    Map<String, Asset> assetsMap = {for (var asset in _assets) asset.id: asset};

    _assets.clear();

    for (var component in _componentFromAsset) {
      if (assetsMap.containsKey(component.parentId)) {
        assetsMap[component.parentId]!.components.add(component);
      }
    }

    _componentFromAsset.clear();

    return assetsMap.values.toList();
  }

  final _subAssets = <Asset>[];
  final _assetFromLocation = <Asset>[];

  /// Separa os Assets dos SubAssets.
  void _separateAssets(List<Asset> assets) {
    for (var asset in assets) {
      if (asset.parentId != null) {
        _subAssets.add(asset);
      } else {
        _assetFromLocation.add(asset);
      }
    }

    assets.clear();
  }

  /// Atribui um SubAsset há um Asset Pai.
  List<Asset> _assignSubAssetToAnAsset() {
    Map<String, Asset> assetsMap = {
      for (var asset in _assetFromLocation) asset.id: asset
    };

    _assetFromLocation.clear();

    for (var subAsset in _subAssets) {
      if (assetsMap.containsKey(subAsset.parentId)) {
        assetsMap[subAsset.parentId]!.subAssets.add(subAsset);
      }
    }

    _subAssets.clear();

    return assetsMap.values.toList();
  }

  /// Atribui um component à um Location.
  List<Location> _assignAComponentToAnLocation() {
    Map<String, Location> locationMap = {
      for (var location in _locations) location.id: location
    };

    _locations.clear();

    for (var component in _componentFromLocation) {
      if (locationMap.containsKey(component.locationId)) {
        locationMap[component.locationId]!.components.add(component);
      }
    }

    _componentFromLocation.clear();

    return locationMap.values.toList();
  }

  /// Atribui um Asset à um Location.
  List<Location> _assignAAssetToAnLocation(
    List<Asset> assets,
    List<Location> locations,
  ) {
    Map<String, Location> locationMap = {
      for (var location in locations) location.id: location
    };

    locations.clear();

    for (var asset in assets) {
      if (locationMap.containsKey(asset.locationId)) {
        locationMap[asset.locationId]!.assets.add(asset);
      }
    }

    assets.clear();

    return locationMap.values.toList();
  }

  final _subLocations = <Location>[];
  final _locationsDad = <Location>[];

  /// Separa os Location dos SubLocation.
  void _separateLocations(List<Location> locations) {
    for (var location in locations) {
      if (location.parentId != null) {
        _subLocations.add(location);
      } else {
        _locationsDad.add(location);
      }
    }

    locations.clear();
  }

  /// Atribui um subLocation há um Location Pai.
  List<Location> _assignSubLocationToAnLocation() {
    Map<String, Location> locationMap = {
      for (var location in _locationsDad) location.id: location
    };

    _locationsDad.clear();

    for (var subLocation in _subLocations) {
      if (locationMap.containsKey(subLocation.parentId)) {
        locationMap[subLocation.parentId]!.subLocations.add(subLocation);
      }
    }

    _subLocations.clear();

    return locationMap.values.toList();
  }

  /// Retorna um map com os Locations e Components externo.
  Set<Object> _joinLists(List<Location> locations) {
    final locationsMap = {for (var location in locations) "Location": location};
    final componentsMap = {
      for (var component in _componentsExternal) "Component": component
    };

    return {locationsMap, componentsMap};
  }

  void _buildHierarchy() {
    final componets = _filterComponents();

    _separateComponents(componets);

    final assets = _assignAComponentToAnAsset();

    _separateAssets(assets);

    final assetsFiltered = _assignSubAssetToAnAsset();

    final locationsWithComponents = _assignAComponentToAnLocation();

    final locationsWithAssets = _assignAAssetToAnLocation(
      assetsFiltered,
      locationsWithComponents,
    );

    _separateLocations(locationsWithAssets);

    final locationsFiltered = _assignSubLocationToAnLocation();

    items = _joinLists(locationsFiltered);

    print(items);
  }
}
