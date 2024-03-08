import '../models/repo_details_model.dart';
import '../models/repos_list_model.dart';

abstract class ReposRepository {
  Future<ReposListModel> getRepos({required String phrase});

  Future<RepoDetailsModel> getRepo({
    required String owner,
    required String repo,
  });

  Future<RepoDetailsModel> getRepoPRs({
    required String owner,
    required String repo,
  });
}
