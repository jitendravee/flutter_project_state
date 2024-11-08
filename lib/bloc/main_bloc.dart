import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:red_core/model/git_repo_model.dart';
import 'package:red_core/model/image_model.dart';
import 'package:red_core/repo/main_repo.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepo mainRepo;

  List<GitRepoModel>? _repoCache;
  List<ImageModel>? _imageCache;

  MainBloc(this.mainRepo) : super(MainInitial()) {
    on<FetchRepoData>(_fetchRepoData);
    on<FetchImageData>(_fetchImageData);
  }

  FutureOr<void> _fetchRepoData(
      FetchRepoData event, Emitter<MainState> emit) async {
    if (_repoCache != null) {
      emit(FetchRepoDataSuccess(data: _repoCache!));
    } else {
      emit(FetchRepoDataLoading());
      try {
        List<GitRepoModel> response = await mainRepo.fetchGitRepoData();
        if (response.isNotEmpty) {
          _repoCache = response;
          emit(FetchRepoDataSuccess(data: response));
        } else {
          emit(FetchRepoDataFailure());
        }
      } catch (e) {
        emit(FetchRepoDataFailure());
      }
    }
  }

  FutureOr<void> _fetchImageData(
      FetchImageData event, Emitter<MainState> emit) async {
    if (_imageCache != null) {
      emit(FetchImageDataSuccess(data: _imageCache!));
    } else {
      emit(FetchImageDataLoading());
      try {
        List<ImageModel> response = await mainRepo.fetchImageData();
        if (response.isNotEmpty) {
          _imageCache = response;
          emit(FetchImageDataSuccess(data: response));
        } else {
          emit(FetchImageDataFailure());
        }
      } catch (e) {
        emit(FetchImageDataFailure());
      }
    }
  }
}
