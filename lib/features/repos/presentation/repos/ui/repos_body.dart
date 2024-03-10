import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../translations/translations.gl.dart';
import '../../../domain/models/repo_list_item_model.dart';
import '../../../domain/models/repos_list_model.dart';
import '../../repo_details/route/repo_details_route.dart';
import '../route/repos_route.dart';

class ReposBody extends StatelessWidget {
  final ReposListModel repos;
  final bool isLoadingMore;

  const ReposBody(this.repos, {this.isLoadingMore = false, super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: repos.items.length,
              itemBuilder: (context, index) => index == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plural(
                            LocaleKeys.repos_results_count,
                            repos.totalCount,
                            args: ['${repos.totalCount}'],
                          ),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 10),
                        _buildRepoItem(context, repos.items[index]),
                      ],
                    )
                  : _buildRepoItem(context, repos.items[index]),
            ),
          ),
          if (isLoadingMore) ...[
            const SizedBox(height: 10),
            const CircularProgressIndicator(),
          ],
        ],
      );

  Widget _buildRepoItem(BuildContext context, RepoListItemModel repo) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () =>
              RepoDetailsRoute(repo.owner.login, repo.name).go(context),
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (repo.owner.avatarUrl != null) ...[
                      SizedBox(
                        width: 20,
                        child: Image.network(repo.owner.avatarUrl!),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Flexible(
                      child: Text(
                        repo.fullName,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (repo.description != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    repo.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
