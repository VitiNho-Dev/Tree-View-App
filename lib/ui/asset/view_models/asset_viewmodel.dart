import 'package:flutter/material.dart';

import '../../../data/repositories/companies_repository.dart';
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

  List<Location> _locations = [];
  List<Location> get locations => _locations;

  Future<Result<void>> _getLocations(String id) async {
    final result = await _companiesRepository.getLocations(id);

    switch (result) {
      case Ok<List<Location>>():
        _locations = result.value;
        notifyListeners();
      case Error<List<Location>>():
        return result;
    }

    return result;
  }
}
