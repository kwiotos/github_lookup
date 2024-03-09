import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/pull_model.dart';
import '../../../domain/use_cases/get_repo_pulls_use_case.dart';

part 'repo_pulls_cubit.freezed.dart';

part 'repo_pulls_state.dart';

@injectable
class RepoPullsCubit extends Cubit<RepoPullsState> {
  final String owner;
  final String repoName;
  final GetRepoPullsUseCase _getRepoPullsUseCase;

  RepoPullsCubit(
    @factoryParam this.owner,
    @factoryParam this.repoName,
    this._getRepoPullsUseCase,
  ) : super(const RepoPullsState.loading());

  Future<void> getRepo() async {
    emit(const RepoPullsState.loading());
    try {
      final pulls = await _getRepoPullsUseCase(owner: owner, repo: repoName);

      emit(RepoPullsState.loaded(pulls: pulls));
    } on Exception {
      emit(const RepoPullsState.error());
    }
  }
}
