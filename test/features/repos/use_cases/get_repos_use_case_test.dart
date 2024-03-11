import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/domain/models/repos_list_model.dart';
import 'package:github_lookup/features/repos/domain/repositories/repos_repository.dart';
import 'package:github_lookup/features/repos/domain/use_cases/get_repos_use_case.dart';
import 'package:mocktail/mocktail.dart';

class ReposRepositoryMock extends Mock implements ReposRepository {}

const _nonemptyPhrase = 'phrase';
const _reposEmptyList = ReposListModel(totalCount: 0, items: []);
const _pageSize = 20;
const _firstPageNumber = 1;

Future<void> main() async {
  final repository = ReposRepositoryMock();

  test('Returns repos when repository gives result', () async {
    final getReposUseCase = GetReposUseCase(repository);

    when(
      () => repository.getRepos(
        phrase: _nonemptyPhrase,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
    ).thenAnswer((_) => Future.value(_reposEmptyList));

    final result = await getReposUseCase(
      phrase: _nonemptyPhrase,
      pageSize: _pageSize,
      pageNumber: _firstPageNumber,
    );

    expect(result, _reposEmptyList);
  });

  test('Throws exception when repository throws it', () async {
    final getReposUseCase = GetReposUseCase(repository);

    when(
      () => repository.getRepos(
        phrase: _nonemptyPhrase,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
    ).thenThrow(Exception());

    expect(
      () => getReposUseCase(
        phrase: _nonemptyPhrase,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
