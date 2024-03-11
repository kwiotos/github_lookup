part of 'repo_pulls_cubit.dart';

@freezed
class RepoPullsState with _$RepoPullsState {
  const factory RepoPullsState.loading({@Default([]) List<PullModel> pulls}) =
      RepoPullsLoading;

  const factory RepoPullsState.loadingMore({
    @Default([]) List<PullModel> pulls,
  }) = RepoPullsLoadingMore;

  const factory RepoPullsState.loaded({required List<PullModel> pulls}) =
      RepoPullsLoaded;

  const factory RepoPullsState.error({@Default([]) List<PullModel> pulls}) =
      RepoPullsError;
}
