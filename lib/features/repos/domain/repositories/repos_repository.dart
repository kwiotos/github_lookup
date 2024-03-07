import '../models/repos_list_model.dart';

abstract class ReposRepository {
  Future<ReposListModel> getRepos({required String phrase});
}
