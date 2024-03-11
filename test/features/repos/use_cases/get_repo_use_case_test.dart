import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/domain/models/repo_details_model.dart';
import 'package:github_lookup/features/repos/domain/models/user_model.dart';
import 'package:github_lookup/features/repos/domain/repositories/repos_repository.dart';
import 'package:github_lookup/features/repos/domain/use_cases/get_repo_use_case.dart';
import 'package:mocktail/mocktail.dart';

class ReposRepositoryMock extends Mock implements ReposRepository {}

const _owner = UserModel(id: 1, login: 'login');
const _repoDetails = RepoDetailsModel(
  id: 1,
  name: 'name',
  owner: _owner,
);

Future<void> main() async {
  final repository = ReposRepositoryMock();

  test('Returns repo details when repository gives result', () async {
    final getRepoUseCase = GetRepoUseCase(repository);

    when(
      () => repository.getRepo(
        owner: _owner.login,
        repo: _repoDetails.name,
      ),
    ).thenAnswer((_) => Future.value(_repoDetails));

    final result = await getRepoUseCase(
      owner: _owner.login,
      repo: _repoDetails.name,
    );

    expect(result, _repoDetails);
  });

  test('Throws exception when repository throws it', () async {
    final getRepoUseCase = GetRepoUseCase(repository);

    when(
      () => repository.getRepo(
        owner: _owner.login,
        repo: _repoDetails.name,
      ),
    ).thenThrow(Exception());

    expect(
      () => getRepoUseCase(
        owner: _owner.login,
        repo: _repoDetails.name,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
