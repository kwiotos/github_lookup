import 'package:injectable/injectable.dart';

import '../models/repos_list_model.dart';
import '../repositories/repos_repository.dart';

@injectable
class GetReposUseCase {
  final ReposRepository _repository;

  GetReposUseCase(this._repository);

  Future<ReposListModel> call({required String phrase}) =>
      _repository.getRepos(phrase: phrase);
}
