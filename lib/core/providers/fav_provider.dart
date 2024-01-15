import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  // List to store favorite movie IDs
  List<int> favoriteMovieIds = [];

  // Check if a movie with a specific ID is marked as a favorite
  bool isMovieFavorite(int movieId) {
    return favoriteMovieIds.contains(movieId);
  }

  // Toggle the favorite status of a movie with a specific ID
  void toggleFavorite(int movieId) {
    if (favoriteMovieIds.contains(movieId)) {
      // Remove the movie from favorites if already present
      favoriteMovieIds.remove(movieId);
    } else {
      // Add the movie to favorites if not present
      favoriteMovieIds.add(movieId);
    }

    // Save the updated favorites to SharedPreferences
    saveFavorites();

    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Save the current list of favorite movie IDs to SharedPreferences
  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the list of favorite movie IDs to a JSON string
    String favString = json.encode(favoriteMovieIds);
    // Save the JSON string to SharedPreferences
    await prefs.setString('favorites', favString);
  }

  // Load the list of favorite movie IDs from SharedPreferences
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the stored JSON string of favorite movie IDs
    String? favString = prefs.getString('favorites');

    if (favString != null) {
      // Decode the JSON string to obtain a list of dynamic objects
      List<dynamic> favList = json.decode(favString);
      // Cast the dynamic list to a list of integers
      favoriteMovieIds = favList.cast<int>();
    }

    // Notify listeners that the state has changed
    notifyListeners();
  }
}
