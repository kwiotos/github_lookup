import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/debouncer.dart';
import '../../domain/models/repo_list_item_model.dart';
import '../../domain/models/repos_list_model.dart';
import 'cubit/repos_cubit.dart';

class ReposScreen extends StatelessWidget {
  ReposScreen({super.key});

  final _debouncer = Debouncer();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Repos screen'),
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
                            child: _buildReposList(state.repos),
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

  Widget _buildReposList(ReposListModel? repos) =>
      repos != null && repos.items.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              itemCount: repos.items.length,
              itemBuilder: (context, index) =>
                  _buildRepoItem(repos.items[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            )
          : const Text('No repos');

  Widget _buildRepoItem(RepoListItemModel repo) => Row(
        children: [
          Text(repo.id.toString()),
          const SizedBox(width: 20),
          Text(repo.name),
        ],
      );
}
