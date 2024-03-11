import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/data/data_sources/remote_data_source/repos_api.dart';
import 'package:github_lookup/features/repos/data/dtos/get_repos_result_dto.dart';
import 'package:github_lookup/features/repos/data/dtos/pull_dto.dart';
import 'package:github_lookup/features/repos/data/dtos/repo_details_dto.dart';
import 'package:github_lookup/features/repos/data/dtos/repo_dto.dart';
import 'package:github_lookup/features/repos/data/dtos/user_dto.dart';
import 'package:github_lookup/features/repos/data/repositories/repos_repository_impl.dart';
import 'package:github_lookup/features/repos/domain/models/pull_model.dart';
import 'package:github_lookup/features/repos/domain/models/repo_details_model.dart';
import 'package:github_lookup/features/repos/domain/models/repo_list_item_model.dart';
import 'package:github_lookup/features/repos/domain/models/repos_list_model.dart';
import 'package:github_lookup/features/repos/domain/models/user_model.dart';
import 'package:mocktail/mocktail.dart';

class ReposApiMock extends Mock implements ReposApi {}

///Common consts
const _nonemptyPhrase = 'phrase';
const _pageSize = 20;
const _firstPageNumber = 1;
const _ownerLogin = 'login';
const _repoName = 'name';

/// Repos consts
const _getReposResultDto = GetReposResultDto(1, [
  RepoDto(
    1,
    'name',
    UserDto(1, 'login', 'avatarUrl'),
    'fullName',
    'description',
  ),
]);
const _reposListModel = ReposListModel(
  totalCount: 1,
  items: [
    RepoListItemModel(
      id: 1,
      name: 'name',
      owner: UserModel(id: 1, login: 'login', avatarUrl: 'avatarUrl'),
      fullName: 'fullName',
      description: 'description',
    ),
  ],
);

///Repo details consts
const _repoDetailsDto = RepoDetailsDto(
  id: 1,
  name: 'name',
  owner: UserDto(1, 'login', 'avatarUrl'),
);

const _repoDetailsModel = RepoDetailsModel(
  id: 1,
  name: 'name',
  owner: UserModel(id: 1, login: 'login', avatarUrl: 'avatarUrl'),
);

///Repo pulls consts
const _pullDto = PullDto(
  1,
  1,
  'title',
  UserDto(1, 'login', 'avatarUrl'),
  '2000-10-31 00:00:00.000Z',
);

final _pullModel = PullModel(
  id: 1,
  number: 1,
  title: 'title',
  user: const UserModel(id: 1, login: 'login', avatarUrl: 'avatarUrl'),
  createdAt: DateTime.utc(2000, 10, 31),
);

Future<void> main() async {
  final api = ReposApiMock();

  test('Returns repos when api gives result', () async {
    final repository = ReposRepositoryImpl(api);

    when(
      () => api.getRepos(_nonemptyPhrase, _pageSize, _firstPageNumber),
    ).thenAnswer((_) => Future.value(_getReposResultDto));

    final result = await repository.getRepos(
      phrase: _nonemptyPhrase,
      pageSize: _pageSize,
      pageNumber: _firstPageNumber,
    );

    expect(result, _reposListModel);
  });

  test('Throws exception on repos fetch when api throws it', () async {
    final repository = ReposRepositoryImpl(api);

    when(
      () => api.getRepos(_nonemptyPhrase, _pageSize, _firstPageNumber),
    ).thenThrow(Exception());

    expect(
      () => repository.getRepos(
        phrase: _nonemptyPhrase,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
      throwsA(isA<Exception>()),
    );
  });

  test('Returns repo details when api gives result', () async {
    final repository = ReposRepositoryImpl(api);

    when(
      () => api.getRepo(_ownerLogin, _repoName),
    ).thenAnswer((_) => Future.value(_repoDetailsDto));

    final result = await repository.getRepo(
      owner: _ownerLogin,
      repo: _repoName,
    );

    expect(result, _repoDetailsModel);
  });

  test('Throws exception on repo details fetch when api throws it', () async {
    final repository = ReposRepositoryImpl(api);

    when(
      () => api.getRepo(_ownerLogin, _repoName),
    ).thenThrow(Exception());

    expect(
      () => repository.getRepo(
        owner: _ownerLogin,
        repo: _repoName,
      ),
      throwsA(isA<Exception>()),
    );
  });

  test('Returns repo pulls when api gives result', () async {
    final repository = ReposRepositoryImpl(api);

    when(
      () => api.getRepoPulls(
        _ownerLogin,
        _repoName,
        _pageSize,
        _firstPageNumber,
      ),
    ).thenAnswer((_) => Future.value([_pullDto]));

    final result = await repository.getRepoPulls(
     owner: _ownerLogin,
     repo: _repoName,
     pageSize: _pageSize,
     pageNumber: _firstPageNumber,
    );

    expect(result, [_pullModel]);
  });

  test('Throws exception on repo pulls fetch when api throws it', () async {
    final repository = ReposRepositoryImpl(api);

    when(
      () => api.getRepoPulls(
        _ownerLogin,
        _repoName,
        _pageSize,
        _firstPageNumber,
      ),
    ).thenThrow(Exception());

    expect(
      () => repository.getRepoPulls(
        owner: _ownerLogin,
        repo: _repoName,
        pageSize: _pageSize,
        pageNumber: _firstPageNumber,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
