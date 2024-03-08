import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/utils/debouncer.dart';
import '../cubit/repos_cubit.dart';
import 'repos_body.dart';

class ReposPage extends StatelessWidget {
  ReposPage({super.key});

  final _debouncer = Debouncer();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Search for repos!'),
        ),
        body: Center(
          child: BlocProvider(
            create: (context) => getIt<ReposCubit>(),
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: LoaderOverlay(
                      overlayColor: Colors.black.withOpacity(0.05),
                      child: Center(
                        child: BlocConsumer<ReposCubit, ReposState>(
                          listener: (context, state) => state.maybeWhen(
                            loading: (_) => context.loaderOverlay.show(),
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
