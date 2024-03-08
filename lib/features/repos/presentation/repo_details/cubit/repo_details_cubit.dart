import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/repo_details_model.dart';
import '../../../domain/models/repos_list_model.dart';
import '../../../domain/use_cases/get_repo_use_case.dart';
import '../../../domain/use_cases/get_repos_use_case.dart';

part 'repo_details_cubit.freezed.dart';

part 'repo_details_state.dart';

@injectable
class RepoDetailsCubit extends Cubit<RepoDetailsState> {
  final String owner;
  final String repoName;
  final GetRepoUseCase _getRepoUseCase;

  RepoDetailsCubit(
    @factoryParam this.owner,
    @factoryParam this.repoName,
    this._getRepoUseCase,
  ) : super(const RepoDetailsState.loading());

  Future<void> getRepo() async {
    emit(const RepoDetailsState.loading());
    try {
      final repo = await _getRepoUseCase(owner: owner, repo: repoName);

      emit(RepoDetailsState.loaded(repo: repo));
    } on Exception {
      emit(const RepoDetailsState.error());
    }
  }
}
