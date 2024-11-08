part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

final class FetchRepoData extends MainEvent {}

final class FetchImageData extends MainEvent {}
