part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class FetchRepoDataSuccess extends MainState {
  final List<MovieModelData> data;
  FetchRepoDataSuccess({required this.data});
}

final class FetchRepoDataLoading extends MainState {}

final class FetchRepoDataFailure extends MainState {}

final class FetchSearchDataSuccess extends MainState {
  final List<MovieModelData> data;
  FetchSearchDataSuccess({required this.data});
}

final class FetchSearchDataLoading extends MainState {}

final class FetchSearchDataFailure extends MainState {}
