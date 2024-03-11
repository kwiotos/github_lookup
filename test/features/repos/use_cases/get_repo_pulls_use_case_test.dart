import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/domain/repositories/repos_repository.dart';
import 'package:github_lookup/features/repos/domain/use_cases/get_repo_pulls_use_case.dart';
import 'package:mocktail/mocktail.dart';

class ReposRepositoryMock extends Mock implements ReposRepository {}

const _ownerLogin = 'login';
const _repoName = 'name';
const _pageSize = 20;
const _firstPageNumber = 1;

Future<void> main() async {
  final repository = ReposRepositoryMock();

  test('Returns repo pulls when repository gives result', () async {
    final getRepoPullsUseCase = GetRepoPullsUseCase(repository);

    when(
      () => repository.getRepoPulls(
        owner: _ownerLogin,
        repo: _repoName,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
    ).thenAnswer((_) => Future.value([]));

    final result = await getRepoPullsUseCase(
      owner: _ownerLogin,
      repo: _repoName,
      pageSize: _pageSize,
      pageNumber: _firstPageNumber,
    );

    expect(result, []);
  });

  test('Throws exception when repository throws it', () async {
    final getRepoPullsUseCase = GetRepoPullsUseCase(repository);

    when(
      () => repository.getRepoPulls(
        owner: _ownerLogin,
        repo: _repoName,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
    ).thenThrow(Exception());

    expect(
      () => getRepoPullsUseCase(
        owner: _ownerLogin,
        repo: _repoName,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
