import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/utils/snackbar_utils.dart';
import '../../../../../core/widgets/loading_overlay.dart';
import '../../../../../translations/translations.gl.dart';
import '../cubit/repos_cubit.dart';
import 'repos_body.dart';

class ReposPage extends StatelessWidget {
  ReposPage({super.key});

  final _debouncer = Debouncer();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(LocaleKeys.repos_title.tr()),
        ),
        body: Center(
          child: BlocProvider(
            create: (context) =>
                getIt<ReposCubit>()..getRepos(phrase: 'flutter'),
            child: Builder(
              builder: (context) => Column(
                children: [
                  ColoredBox(
                    color: Theme.of(context).colorScheme.background,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onChanged: (text) => _debouncer.run(
                              () => BlocProvider.of<ReposCubit>(context)
                                  .getRepos(phrase: text),
                            ),
                            decoration: InputDecoration(
                              hintText: LocaleKeys.repos_input_hint.tr(),
                              prefixIcon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Flexible(
                    child: BlocConsumer<ReposCubit, ReposState>(
                      listener: (context, state) => state.whenOrNull(
                        error: (_) => SnackBarUtils.showErrorSnackBar(context),
                      ),
                      builder: (context, state) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: state.when(
                          initial: (repos) => Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child:
                                Text(LocaleKeys.repos_no_phrase_message.tr()),
                          ),
                          loading: (repos) => repos != null
                              ? LoadingOverlay(child: ReposBody(repos))
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: CircularProgressIndicator(),
                                ),
                          loadingMore: (repos) => repos != null
                              ? ReposBody(repos, isLoadingMore: true)
                              : const SizedBox.shrink(),
                          loaded: (repos) => repos.items.isNotEmpty
                              ? ReposBody(repos)
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(LocaleKeys.repos_empty.tr()),
                                ),
                          error: (repos) => repos != null
                              ? ReposBody(repos)
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child:
                                      Text(LocaleKeys.base_error_message.tr()),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
