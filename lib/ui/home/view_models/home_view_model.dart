import 'package:flutter/material.dart';
import 'package:tree_view_app/utils/command.dart';

import '../../../data/repositories/companies_repository.dart';
import '../../../domain/models/companie.dart';
import '../../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final CompaniesRepository _companiesRepository;

  HomeViewModel({
    required CompaniesRepository companiesRepository,
  }) : _companiesRepository = companiesRepository {
    getCompanies = Command0(_getCompanies)..execute();
  }

  late final Command0 getCompanies;

  List<Companie> _companies = [];
  List<Companie> get companies => _companies;

  Future<Result> _getCompanies() async {
    final result = await _companiesRepository.getCompanies();

    switch (result) {
      case Ok<List<Companie>>():
        _companies = result.value;
        notifyListeners();
      case Error<List<Companie>>():
        return result;
    }

    return result;
  }
}
