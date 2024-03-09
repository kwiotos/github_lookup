import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../translations/translations.gl.dart';
import '../cubit/repo_pulls_cubit.dart';
import 'repo_pulls_body.dart';

class RepoPullsPage extends StatelessWidget {
  final String owner;
  final String repo;

  const RepoPullsPage(this.owner, this.repo, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(LocaleKeys.repo_pulls_title.tr(args: [repo])),
        ),
        body: Center(
          child: BlocProvider(
            create: (context) =>
                getIt<RepoPullsCubit>(param1: owner, param2: repo)..getRepo(),
            child: BlocBuilder<RepoPullsCubit, RepoPullsState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: state.when(
                    loading: () => const CircularProgressIndicator(),
                    loaded: RepoPullsBody.new,
                    error: () => Text(LocaleKeys.base_error_message.tr()),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
