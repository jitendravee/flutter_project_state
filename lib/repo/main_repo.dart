import 'package:dio/dio.dart';
import 'package:red_core/model/git_repo_model.dart';
import 'package:red_core/model/image_model.dart';

class MainRepo {
  final Dio? _dio = Dio();

  Future<List<GitRepoModel>> fetchGitRepoData() async {
    try {
      final Response response =
          await _dio!.get('https://api.github.com/gists/public');
      if (response.data != null) {
        return (response.data as List)
            .map((item) => GitRepoModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Git repositories: $e');
      return [];
    }
  }

  Future<List<ImageModel>> fetchImageData() async {
    try {
      final Response response = await _dio!.get(
          'https://api.unsplash.com/photos/?client_id=ccMuvzc_8xQHsUp8DqYlW4Oh4fMetRM2lAhTx-KCfJU');
      if (response.data != null) {
        return (response.data as List)
            .map((item) => ImageModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Git repositories: $e');
      return [];
    }
  }
}
