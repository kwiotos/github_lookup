import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/repos_list_model.dart';
import '../../../domain/use_cases/get_repos_use_case.dart';

part 'repos_cubit.freezed.dart';

part 'repos_state.dart';

const _pageSize = 20;

@injectable
class ReposCubit extends Cubit<ReposState> {
  final GetReposUseCase _getReposUseCase;

  ReposCubit(this._getReposUseCase) : super(const ReposState.initial());

  String currentPhrase = '';
  int pageNumber = 1;

  Future<void> getRepos({required String phrase}) async {
    pageNumber = 1;
    currentPhrase = phrase;

    emit(ReposState.loading(repos: state.repos));

    if (phrase.isEmpty) {
      emit(const ReposState.initial());

      return;
    }

    try {
      final repos = await _getReposUseCase(
        phrase: phrase,
        pageSize: _pageSize,
        pageNumber: pageNumber,
      );

      emit(ReposState.loaded(repos: repos));
    } on Exception {
      emit(ReposState.error(repos: state.repos));
    }
  }

  Future<void> getMoreRepos() async {
    pageNumber++;
    emit(ReposState.loadingMore(repos: state.repos));

    try {
      final repos = await _getReposUseCase(
        phrase: currentPhrase,
        pageSize: _pageSize,
        pageNumber: pageNumber,
      );

      emit(
        ReposState.loaded(
          repos: ReposListModel(
            totalCount: repos.totalCount,
            items: [...state.repos?.items ?? [], ...repos.items],
          ),
        ),
      );
    } on Exception {
      pageNumber--;
      emit(ReposState.error(repos: state.repos));
    }
  }
}
