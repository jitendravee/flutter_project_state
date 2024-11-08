part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class FetchRepoDataSuccess extends MainState {
  final List<GitRepoModel> data;
  FetchRepoDataSuccess({required this.data});
}

final class FetchRepoDataLoading extends MainState {}

final class FetchRepoDataFailure extends MainState {}

final class FetchImageDataSuccess extends MainState {
  final List<ImageModel> data;
  FetchImageDataSuccess({required this.data});
}

final class FetchImageDataLoading extends MainState {}

final class FetchImageDataFailure extends MainState {}
