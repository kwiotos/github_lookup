import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_lookup/features/repos/domain/models/repo_details_model.dart';
import 'package:github_lookup/features/repos/domain/models/user_model.dart';
import 'package:github_lookup/features/repos/domain/use_cases/get_repo_use_case.dart';
import 'package:github_lookup/features/repos/presentation/repo_details/cubit/repo_details_cubit.dart';
import 'package:mocktail/mocktail.dart';

class GetRepoUseCaseMock extends Mock implements GetRepoUseCase {}

const _owner = UserModel(id: 1, login: 'login');
const _repoDetails = RepoDetailsModel(
  id: 1,
  name: 'name',
  owner: _owner,
);

Future<void> main() async {
  final getRepoDetailsUseCase = GetRepoUseCaseMock();

  group('Get repo test', () {
    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'Emits [loading, loaded] when repo is successfully fetched',
      build: () {
        when(
          () => getRepoDetailsUseCase(
            owner: _owner.login,
            repo: _repoDetails.name,
          ),
        ).thenAnswer((_) => Future.value(_repoDetails));

        return RepoDetailsCubit(
          _owner.login,
          _repoDetails.name,
          getRepoDetailsUseCase,
        );
      },
      act: (cubit) => cubit.getRepo(),
      expect: () => const <RepoDetailsState>[
        RepoDetailsState.loading(),
        RepoDetailsState.loaded(repo: _repoDetails),
      ],
    );

    blocTest<RepoDetailsCubit, RepoDetailsState>(
      'Emits [loading, error] when exception is thrown',
      build: () {
        when(
          () => getRepoDetailsUseCase(
            owner: _owner.login,
            repo: _repoDetails.name,
          ),
        ).thenThrow(Exception());

        return RepoDetailsCubit(
          _owner.login,
          _repoDetails.name,
          getRepoDetailsUseCase,
        );
      },
      act: (cubit) => cubit.getRepo(),
      expect: () => const <RepoDetailsState>[
        RepoDetailsState.loading(),
        RepoDetailsState.error(),
      ],
    );
  });
}
