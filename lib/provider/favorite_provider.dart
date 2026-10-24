import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<int> _favorites = {};
  Set<int> get favorites => _favorites;

  bool isFavorite(int id) {
    return _favorites.contains(id);
  }

  void toggleFavorite(int id) {
    if (isFavorite(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }
}
