import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/domain/models/repos_list_model.dart';
import 'package:github_lookup/features/repos/domain/use_cases/get_repos_use_case.dart';
import 'package:github_lookup/features/repos/presentation/repos/cubit/repos_cubit.dart';
import 'package:mocktail/mocktail.dart';

class GetReposUseCaseMock extends Mock implements GetReposUseCase {}

const _emptyPhrase = '';
const _nonemptyPhrase = 'phrase';
const _reposEmptyList = ReposListModel(totalCount: 0, items: []);
const _pageSize = 20;
const _firstPageNumber = 1;
const _secondPageNumber = 2;

Future<void> main() async {
  final getReposUseCase = GetReposUseCaseMock();

  group('Get repos test', () {
    blocTest<ReposCubit, ReposState>(
      'Emits [loading, initial] when empty phrase is entered',
      build: () => ReposCubit(getReposUseCase),
      act: (cubit) => cubit.getRepos(phrase: _emptyPhrase),
      expect: () => const <ReposState>[
        ReposState.loading(),
        ReposState.initial(),
      ],
    );

    blocTest<ReposCubit, ReposState>(
      'Emits [loading, loaded] when repos are successfully fetched on nonempty phrase',
      build: () {
        when(
          () => getReposUseCase(
            phrase: _nonemptyPhrase,
            pageSize: _pageSize,
            pageNumber: _firstPageNumber,
          ),
        ).thenAnswer((_) => Future.value(_reposEmptyList));

        return ReposCubit(getReposUseCase);
      },
      act: (cubit) => cubit.getRepos(phrase: _nonemptyPhrase),
      expect: () => const <ReposState>[
        ReposState.loading(),
        ReposState.loaded(repos: _reposEmptyList),
      ],
    );

    blocTest<ReposCubit, ReposState>(
      'Emits [loading, error] when exception is thrown',
      build: () {
        when(
          () => getReposUseCase(
            phrase: _nonemptyPhrase,
            pageSize: _pageSize,
            pageNumber: _firstPageNumber,
          ),
        ).thenThrow(Exception());

        return ReposCubit(getReposUseCase);
      },
      act: (cubit) => cubit.getRepos(phrase: _nonemptyPhrase),
      expect: () => const <ReposState>[
        ReposState.loading(),
        ReposState.error(),
      ],
    );
  });

  group('Get more repos test', () {
    blocTest<ReposCubit, ReposState>(
      'Emits [loadingMore, loaded] when repos are successfully fetched',
      build: () {
        when(
              () => getReposUseCase(
            phrase: _emptyPhrase,
            pageSize: _pageSize,
            pageNumber: _secondPageNumber,
          ),
        ).thenAnswer((_) => Future.value(_reposEmptyList));

        return ReposCubit(getReposUseCase);
      },
      act: (cubit) => cubit.getMoreRepos(),
      expect: () => const <ReposState>[
        ReposState.loadingMore(),
        ReposState.loaded(repos: _reposEmptyList),
      ],
    );

    blocTest<ReposCubit, ReposState>(
      'Emits [loadingMore, error] when exception is thrown',
      build: () {
        when(
              () => getReposUseCase(
            phrase: _emptyPhrase,
            pageSize: _pageSize,
            pageNumber: _secondPageNumber,
          ),
        ).thenThrow(Exception());

        return ReposCubit(getReposUseCase);
      },
      act: (cubit) => cubit.getMoreRepos(),
      expect: () => const <ReposState>[
        ReposState.loadingMore(),
        ReposState.error(),
      ],
    );
  });
}
