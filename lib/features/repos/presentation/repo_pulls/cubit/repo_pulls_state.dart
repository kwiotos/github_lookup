part of 'repo_pulls_cubit.dart';

@freezed
class RepoPullsState with _$RepoPullsState {
  const factory RepoPullsState.loading() = RepoPullsLoading;

  const factory RepoPullsState.loaded({required List<PullModel> pulls}) =
      RepoPullsLoaded;

  const factory RepoPullsState.error() = RepoPullsError;
}
