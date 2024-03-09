import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/repos_list_model.dart';
import '../../../domain/use_cases/get_repos_use_case.dart';

part 'repos_cubit.freezed.dart';

part 'repos_state.dart';

@injectable
class ReposCubit extends Cubit<ReposState> {
  final GetReposUseCase _getReposUseCase;

  ReposCubit(this._getReposUseCase) : super(const ReposState.initial());

  Future<void> getRepos({required String phrase}) async {
    emit(ReposState.loading(repos: state.repos));

    if (phrase.isEmpty) {
      emit(const ReposState.initial());

      return;
    }

    try {
      final repos = await _getReposUseCase(phrase: phrase);

      emit(ReposState.loaded(repos: repos));
    } on Exception {
      emit(ReposState.error(repos: state.repos));
    }
  }
}
