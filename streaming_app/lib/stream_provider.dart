import 'package:flutter/material.dart';

class CustomStreamProvider with ChangeNotifier {
  final List<String> _streams = [];

  List<String> get streams => _streams;

  void addStream(String stream) {
    _streams.add(stream);
    notifyListeners();
  }
}
