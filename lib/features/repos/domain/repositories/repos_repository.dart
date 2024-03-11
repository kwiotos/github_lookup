import '../models/pull_model.dart';
import '../models/repo_details_model.dart';
import '../models/repos_list_model.dart';

abstract class ReposRepository {
  Future<ReposListModel> getRepos({
    required String phrase,
    required int pageSize,
    required int pageNumber,
  });

  Future<RepoDetailsModel> getRepo({
    required String owner,
    required String repo,
  });

  Future<List<PullModel>> getRepoPulls({
    required String owner,
    required String repo,
    required int pageSize,
    required int pageNumber,
  });
}
