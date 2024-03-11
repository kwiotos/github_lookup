import 'package:injectable/injectable.dart';

import '../../domain/models/pull_model.dart';
import '../../domain/models/repo_details_model.dart';
import '../../domain/models/repos_list_model.dart';
import '../../domain/repositories/repos_repository.dart';
import '../data_sources/remote_data_source/repos_api.dart';

@LazySingleton(as: ReposRepository)
class ReposRepositoryImpl extends ReposRepository {
  final ReposApi _reposApi;

  ReposRepositoryImpl(this._reposApi);

  @override
  Future<ReposListModel> getRepos({
    required String phrase,
    required int pageSize,
    required int pageNumber,
  }) async {
    final result = await _reposApi.getRepos(phrase, pageSize, pageNumber);

    return result.toModel();
  }

  @override
  Future<RepoDetailsModel> getRepo({
    required String owner,
    required String repo,
  }) async {
    final result = await _reposApi.getRepo(owner, repo);

    return result.toModel();
  }

  @override
  Future<List<PullModel>> getRepoPulls({
    required String owner,
    required String repo,
    required int pageSize,
    required int pageNumber,
  }) async {
    final result = await _reposApi.getRepoPulls(
      owner,
      repo,
      pageSize,
      pageNumber,
    );

    return result.map((e) => e.toModel()).toList();
  }
}
