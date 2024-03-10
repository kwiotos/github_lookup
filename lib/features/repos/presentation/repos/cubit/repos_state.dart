part of 'repos_cubit.dart';

@freezed
class ReposState with _$ReposState {
  const factory ReposState.initial({ReposListModel? repos}) = ReposInitial;

  const factory ReposState.loading({ReposListModel? repos}) = ReposLoading;

  const factory ReposState.loadingMore({ReposListModel? repos}) = ReposLoadingMore;

  const factory ReposState.loaded({required ReposListModel repos}) =
      ReposLoaded;

  const factory ReposState.error({ReposListModel? repos}) = ReposError;
}
