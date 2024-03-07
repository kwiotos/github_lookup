part of 'repos_cubit.dart';

@freezed
class ReposState with _$ReposState {
  const factory ReposState.loading({ReposListModel? repos}) = ReposLoading;

  const factory ReposState.loaded({ReposListModel? repos}) = ReposLoaded;

  const factory ReposState.error({ReposListModel? repos}) = ReposError;
}
