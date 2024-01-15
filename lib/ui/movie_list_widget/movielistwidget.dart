import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_url.dart';
import '../../core/models/movies_model.dart';
import '../../core/providers/fav_provider.dart';
import '../../core/services/movie_services.dart';
import '../../core/utils/mySize.dart';
import '../../core/utils/theme_helper.dart';
import '../favotites/favorite_movies.dart';

// Define the MovieListWidget class, which is a StatefulWidget
class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

// Define the state for MovieListWidget
class _MovieListWidgetState extends State<MovieListWidget> {
  // List to store movie data
  List<Movie> moviesData = [];

  @override
  Widget build(BuildContext context) {
    // Initialize MySize class
    MySize().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        foregroundColor: Colors.white,
        backgroundColor: ThemeColors.mainColor,
        actions: [
          // Add an icon button to navigate to the FavoritesMoviesScreen
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteMoviesScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // Define the body of the Scaffold
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              // Fetch movies asynchronously using MovieService
              future: MovieService.fetchMovies(),
              builder: (context, snapshot) {
                // Handle different states: loading, completed, or error
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while data is being fetched
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.mainColor,
                    ),
                  );
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
                }
                else if (snapshot.error is NoInternetException) {
                  NoInternetException noInternetException = snapshot.error as NoInternetException;
                  return Center(
                    child: Text('Internet Connection: ${noInternetException.message}'),
                  );
                }
                else {
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
                  return ListView.builder(
                    itemCount: moviesData.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Consumer<FavoriteProvider>(
                        builder: (context, favProvider, child) {
                          // Load favorite movies from storage
                          favProvider.loadFavorites();

                          // Extract movie ID and check if it's a favorite
                          int? movieId = moviesData[index].id;
                          bool isFavorite =
                          favProvider.favoriteMovieIds.contains(movieId!);

                          // Return a ListTile with movie information
                          return ListTile(
                            title: Text(moviesData[index].title!),
                            subtitle: Text(
                              moviesData[index].overview!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CachedNetworkImage(
                              width: 50.0,
                              height: 100.0,
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
                            trailing: IconButton(
                              // Add an IconButton to toggle movie as favorite
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: ThemeColors.mainColor,
                              ),
                              onPressed: () async {
                                // Toggle the favorite status and save changes
                                favProvider.toggleFavorite(movieId);
                                await favProvider.saveFavorites();
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
