import 'package:injectable/injectable.dart';

import '../models/pull_model.dart';
import '../repositories/repos_repository.dart';

@injectable
class GetRepoPullsUseCase {
  final ReposRepository _repository;

  GetRepoPullsUseCase(this._repository);

  Future<List<PullModel>> call({
    required String owner,
    required String repo,
    required int pageSize,
    required int pageNumber,
  }) =>
      _repository.getRepoPulls(
        owner: owner,
        repo: repo,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );
}
