import 'package:dio/dio.dart';
import 'package:red_core/model/movie_repo_model.dart';

class MainRepo {
  final Dio? _dio = Dio();

  Future<List<MovieModelData>> fetchGitRepoData() async {
    try {
      final Response response =
          await _dio!.get('https://api.tvmaze.com/search/shows?q=all');
      if (response.data != null) {
        return (response.data as List)
            .map((item) => MovieModelData.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Git repositories: $e');
      return [];
    }
  }

  Future<List<MovieModelData>> fetchImageData(String paramerterSearch) async {
    try {
      final Response response = await _dio!
          .get('https://api.tvmaze.com/search/shows?q=${paramerterSearch}');
      if (response.data != null) {
        return (response.data as List)
            .map((item) => MovieModelData.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Git repositories: $e');
      return [];
    }
  }
}
