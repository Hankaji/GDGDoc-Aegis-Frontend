
import 'package:flutter/material.dart';
import 'place.dart';

class SearchModel extends ChangeNotifier {
  List<Place> _suggestions = [];
  bool _isLoading = false;
  String _query = '';

  List<Place> get suggestions => _suggestions;
  bool get isLoading => _isLoading;
  String get query => _query;

  // Sample history data
  static final List<Place> history = [
    Place(name: 'Tel Aviv', level2Address: 'Israel'),
    Place(name: 'Jerusalem', level2Address: 'Israel'),
    Place(name: 'Haifa', level2Address: 'Israel'),
  ];

  Future<void> onQueryChanged(String query) async {
    _query = query;
    
    if (query.isEmpty) {
      _suggestions = history;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    // Simulate network request
    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    
    // Filter or fetch suggestions based on query
    _suggestions = [
      Place(name: '$query Option 1', level2Address: 'Test address 1'),
      Place(name: '$query Option 2', level2Address: 'Test address 2'),
      Place(name: '$query Option 3', level2Address: 'Test address 3'),
    ];

    notifyListeners();
  }

  void clear() {
    _query = '';
    _suggestions = [];
    notifyListeners();
  }
}
