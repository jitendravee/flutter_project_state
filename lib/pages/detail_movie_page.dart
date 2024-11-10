import 'package:flutter/material.dart';
import 'package:red_core/model/movie_repo_model.dart' as model;

class DetailMoviePage extends StatelessWidget {
  final model.MovieModelData movie;

  const DetailMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    String cleanHtmlTags(String text) {
      final regExp = RegExp(r'<[^>]*>');
      return text.replaceAll(regExp, '');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.show?.name ?? 'Movie Details'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  movie.show?.image?.original ?? '',
                  width: 250,
                  height: 350,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.show?.name ?? 'No Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                cleanHtmlTags(
                    movie.show?.summary ?? 'No description available.'),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (movie.show?.genres != null) ...[
                Text(
                  'Genres: ${movie.show?.genres?.join(', ') ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
              ],
              if (movie.show?.premiered != null) ...[
                Text(
                  'Premiered: ${movie.show?.premiered ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
              ],
              if (movie.show?.rating?.average != null) ...[
                Text(
                  'Rating: ${movie.show?.rating?.average ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
