import 'dart:async';

import 'package:flutter/material.dart';

class PageManager extends ChangeNotifier {
  Completer<String>? _completer;

  Future<String> waitForResult() async {
    _completer = Completer<String>();
    return _completer!.future;
  }

  void returnData(String value) {
    if (_completer != null) {
      _completer!.complete(value);
    }
  }
}
