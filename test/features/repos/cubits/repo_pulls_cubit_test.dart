import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/domain/use_cases/get_repo_pulls_use_case.dart';
import 'package:github_lookup/features/repos/presentation/repo_pulls/cubit/repo_pulls_cubit.dart';
import 'package:mocktail/mocktail.dart';

class GetRepoPullsUseCaseMock extends Mock implements GetRepoPullsUseCase {}

const _ownerLogin = 'login';
const _repoName = 'name';
const _pageSize = 20;
const _firstPageNumber = 1;
const _secondPageNumber = 2;

Future<void> main() async {
  final getRepoPullsUseCase = GetRepoPullsUseCaseMock();

  group('Get repo pulls test', () {
    blocTest<RepoPullsCubit, RepoPullsState>(
      'Emits [loading, loaded] when repo pulls are successfully fetched',
      build: () {
        when(
          () => getRepoPullsUseCase(
            owner: _ownerLogin,
            repo: _repoName,
            pageSize: _pageSize,
            pageNumber: _firstPageNumber,
          ),
        ).thenAnswer((_) => Future.value([]));

        return RepoPullsCubit(_ownerLogin, _repoName, getRepoPullsUseCase);
      },
      act: (cubit) => cubit.getPulls(),
      expect: () => const <RepoPullsState>[
        RepoPullsState.loading(),
        RepoPullsState.loaded(pulls: []),
      ],
    );

    blocTest<RepoPullsCubit, RepoPullsState>(
      'Emits [loading, error] when exception is thrown',
      build: () {
        when(
          () => getRepoPullsUseCase(
            owner: _ownerLogin,
            repo: _repoName,
            pageSize: _pageSize,
            pageNumber: _firstPageNumber,
          ),
        ).thenThrow(Exception());

        return RepoPullsCubit(_ownerLogin, _repoName, getRepoPullsUseCase);
      },
      act: (cubit) => cubit.getPulls(),
      expect: () => const <RepoPullsState>[
        RepoPullsState.loading(),
        RepoPullsState.error(),
      ],
    );
  });

  group('Get more repo pulls test', () {
    blocTest<RepoPullsCubit, RepoPullsState>(
      'Emits [loadingMore, loaded] when repos are successfully fetched',
      build: () {
        when(
          () => getRepoPullsUseCase(
            owner: _ownerLogin,
            repo: _repoName,
            pageSize: _pageSize,
            pageNumber: _secondPageNumber,
          ),
        ).thenAnswer((_) => Future.value([]));

        return RepoPullsCubit(_ownerLogin, _repoName, getRepoPullsUseCase);
      },
      act: (cubit) => cubit.getMorePulls(),
      expect: () => const <RepoPullsState>[
        RepoPullsState.loadingMore(),
        RepoPullsState.loaded(pulls: []),
      ],
    );

    blocTest<RepoPullsCubit, RepoPullsState>(
      'Emits [loadingMore, error] when exception is thrown',
      build: () {
        when(
          () => getRepoPullsUseCase(
            owner: _ownerLogin,
            repo: _repoName,
            pageSize: _pageSize,
            pageNumber: _secondPageNumber,
          ),
        ).thenThrow(Exception());

        return RepoPullsCubit(_ownerLogin, _repoName, getRepoPullsUseCase);
      },
      act: (cubit) => cubit.getMorePulls(),
      expect: () => const <RepoPullsState>[
        RepoPullsState.loadingMore(),
        RepoPullsState.error(),
      ],
    );
  });
}
