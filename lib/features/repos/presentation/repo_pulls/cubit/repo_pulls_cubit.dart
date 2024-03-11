import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/pull_model.dart';
import '../../../domain/use_cases/get_repo_pulls_use_case.dart';

part 'repo_pulls_cubit.freezed.dart';

part 'repo_pulls_state.dart';

const _pageSize = 20;

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

  int pageNumber = 1;

  Future<void> getPulls() async {
    pageNumber = 1;
    emit(RepoPullsState.loading(pulls: state.pulls));
    try {
      final pulls = await _getRepoPullsUseCase(
        owner: owner,
        repo: repoName,
        pageSize: _pageSize,
        pageNumber: pageNumber,
      );

      emit(RepoPullsState.loaded(pulls: pulls));
    } on Exception {
      emit(const RepoPullsState.error());
    }
  }

  Future<void> getMorePulls() async {
    pageNumber++;
    emit(RepoPullsState.loadingMore(pulls: state.pulls));

    try {
      final pulls = await _getRepoPullsUseCase(
        owner: owner,
        repo: repoName,
        pageSize: _pageSize,
        pageNumber: pageNumber,
      );

      emit(RepoPullsState.loaded(pulls: [...state.pulls, ...pulls]));
    } on Exception {
      pageNumber--;
      emit(RepoPullsState.error(pulls: state.pulls));
    }
  }
}
