import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/utils/snackbar_utils.dart';
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
            create: (context) => getIt<ReposCubit>()..getRepos(phrase: ''),
            child: Builder(
              builder: (context) => Column(
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: LoaderOverlay(
                      overlayColor: Colors.black.withOpacity(0.05),
                      child: Center(
                        child: BlocConsumer<ReposCubit, ReposState>(
                          listener: (context, state) => state.maybeWhen<void>(
                            loading: (_) => context.loaderOverlay.show(),
                            error: (_) {
                              context.loaderOverlay.hide();
                              SnackBarUtils.showErrorSnackBar(context);
                            },
                            orElse: () => context.loaderOverlay.hide(),
                          ),
                          builder: (context, state) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ReposBody(state.repos),
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
