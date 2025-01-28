import 'package:flutter/material.dart';

import 'result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();

abstract class Command<T> extends ChangeNotifier {
  bool _running = false;

  bool get running => _running;

  Result<T>? _result;

  bool get completed => _result is Ok;

  bool get error => _result is Error;

  Result<T>? get resutl => _result;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

final class Command0<T> extends Command<T> {
  final CommandAction0<T> _action;

  Command0(this._action);

  Future<void> execute() async {
    await _execute(_action);
  }
}
