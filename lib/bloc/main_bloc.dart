import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:red_core/model/movie_repo_model.dart';

import 'package:red_core/repo/main_repo.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepo mainRepo;

  List<MovieModelData>? _repoCache;

  MainBloc(this.mainRepo) : super(MainInitial()) {
    on<FetchRepoData>(_fetchRepoData);
    on<FetchSearchData>(_fetchSearchData);
  }

  FutureOr<void> _fetchRepoData(
      FetchRepoData event, Emitter<MainState> emit) async {
    if (_repoCache != null) {
      emit(FetchRepoDataSuccess(data: _repoCache!));
    } else {
      emit(FetchRepoDataLoading());
      try {
        List<MovieModelData> response = await mainRepo.fetchGitRepoData();
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

  FutureOr<void> _fetchSearchData(
      FetchSearchData event, Emitter<MainState> emit) async {
    emit(FetchSearchDataLoading());
    try {
      List<MovieModelData> response =
          await mainRepo.fetchImageData(event.paramerterSearch);
      if (response.isNotEmpty) {
        emit(FetchSearchDataSuccess(data: response));
      } else {
        emit(FetchSearchDataFailure());
      }
    } catch (e) {
      emit(FetchSearchDataFailure());
    }
  }
}
