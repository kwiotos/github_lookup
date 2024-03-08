part of 'repo_details_cubit.dart';

@freezed
class RepoDetailsState with _$RepoDetailsState {
  const factory RepoDetailsState.loading() = RepoDetailsLoading;

  const factory RepoDetailsState.loaded({required RepoDetailsModel repo}) =
      RepoDetailsLoaded;

  const factory RepoDetailsState.error() = RepoDetailsError;
}
