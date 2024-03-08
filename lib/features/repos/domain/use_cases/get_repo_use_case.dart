import 'package:injectable/injectable.dart';

import '../models/repo_details_model.dart';
import '../models/repos_list_model.dart';
import '../repositories/repos_repository.dart';

@injectable
class GetRepoUseCase {
  final ReposRepository _repository;

  GetRepoUseCase(this._repository);

  Future<RepoDetailsModel> call({
    required String owner,
    required String repo,
  }) =>
      _repository.getRepo(owner: owner, repo: repo);
}
