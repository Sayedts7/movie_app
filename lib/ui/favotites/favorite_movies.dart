// Import necessary packages and files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_url.dart';
import '../../core/models/movies_model.dart';
import '../../core/providers/fav_provider.dart';
import '../../core/services/movie_services.dart';
import '../../core/utils/mySize.dart';
import '../../core/utils/theme_helper.dart';

// Define FavoriteMoviesScreen class, which is a StatefulWidget
class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

// Define the state for FavoriteMoviesScreen
class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  // Initialize MovieService class
  MovieService movieService = MovieService();

  // List to store favorite movies data
  List<Movie> moviesData = [];

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      // Define the AppBar
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        foregroundColor: Colors.white,
        title: const Text('Favorite Movies'),
      ),
      // Define the body of the Scaffold
      body: FutureBuilder(
        // Fetch movies asynchronously using MovieService
        future: MovieService.fetchMovies(),
        builder: (context, snapshot) {
          // Handle different states: loading, completed, or error
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while data is being fetched
            return const Center(
                child: CircularProgressIndicator(
                  color: ThemeColors.mainColor,
                ));
          } else if (snapshot.hasError) {
            // Handle the error within the FutureBuilder
            if (snapshot.error is ApiException) {
              ApiException apiException = snapshot.error as ApiException;
              // Handle ApiException specifically
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text('API Error: ${apiException.message}'),
                ),
              );
            } else {
              // Handle other types of errors
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }
          } else {
            // If data is successfully fetched, populate the ListView
            moviesData = snapshot.data!;
            return Consumer<FavoriteProvider>(
              builder: (context, favProvider, child) {
                // Extract the list of favorite movie IDs
                List<int> favoriteMovieIds = favProvider.favoriteMovieIds;

                // Filter out favorite movies from the fetched data
                List<Movie> favoriteMovies = moviesData
                    .where((movie) => favoriteMovieIds.contains(movie.id))
                    .toList();

                // Display text if there are no favorite movies
                if (favoriteMovies.isEmpty) {
                  return const Center(child: Text('No favorite movies yet'));
                } else {
                  // Return a ListView of favorite movies
                  return ListView.builder(
                    itemCount: favoriteMovies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(favoriteMovies[index].title!),
                        subtitle: Text(
                          favoriteMovies[index].overview!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CachedNetworkImage(
                          width: MySize.size50,
                          height: MySize.size100,
                          fit: BoxFit.cover,
                          imageUrl:
                          AppUrl.imageLink + moviesData[index].posterPath!,
                          progressIndicatorBuilder: (context, url,
                              downloadProgress) =>
                              Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
