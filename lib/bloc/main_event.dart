part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

final class FetchRepoData extends MainEvent {}

final class FetchSearchData extends MainEvent {
  final String paramerterSearch;
  FetchSearchData({required this.paramerterSearch});
}
