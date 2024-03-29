import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../translations/translations.gl.dart';
import '../cubit/repo_details_cubit.dart';
import 'repo_details_body.dart';

class RepoDetailsPage extends StatelessWidget {
  final String owner;
  final String repo;

  const RepoDetailsPage(this.owner, this.repo, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(LocaleKeys.repo_details_title.tr(args: [repo])),
        ),
        body: Center(
          child: BlocProvider(
            create: (context) =>
                getIt<RepoDetailsCubit>(param1: owner, param2: repo)..getRepo(),
            child: BlocBuilder<RepoDetailsCubit, RepoDetailsState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: state.when(
                    loading: () => const CircularProgressIndicator(),
                    loaded: RepoDetailsBody.new,
                    error: () => Text(LocaleKeys.base_error_message.tr()),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
