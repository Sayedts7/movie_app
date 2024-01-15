import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/app_url.dart';
import '../models/movies_model.dart';
import '../utils/global_functions.dart';

class MovieService {
  static Future<List<Movie>> fetchMovies() async {
    try {
      if (!( await GlobalFunctions.checkInternetConnection())) {
        throw NoInternetException('No internet connection');
      }
      final headers = {
        'api-key': AppUrl.apiKey,
        'Content-Type': 'application/json',
      };

      const apiUrl = AppUrl.movies;
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['results'];

        List<Movie> moviesList = jsonResponse.map((movieJson) {
          return Movie.fromJson(movieJson);
        }).toList();

        return moviesList;
      } else {
        // Throw a custom exception with a meaningful error message
        throw ApiException('Failed to load data from the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions and provide additional details if needed
      print('An error occurred: $e');
      // You can choose to rethrow the caught exception or return a default value
      throw e; // or return an empty list: return [];
    }
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

// Custom exception class for no internet connection
class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);

  @override
  String toString() => 'NoInternetException: $message';
}