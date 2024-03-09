import 'package:flutter/material.dart';

import '../../../domain/models/repo_list_item_model.dart';
import '../../../domain/models/repos_list_model.dart';
import '../../repo_details/route/repo_details_route.dart';
import '../route/repos_route.dart';

class ReposBody extends StatelessWidget {
  final ReposListModel? repos;

  const ReposBody(this.repos, {super.key});

  @override
  Widget build(BuildContext context) => repos != null && repos!.items.isNotEmpty
      ? ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          itemCount: repos!.items.length,
          itemBuilder: (context, index) =>
              _buildRepoItem(context, repos!.items[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        )
      : const Text('No repos');

  Widget _buildRepoItem(BuildContext context, RepoListItemModel repo) =>
      InkWell(
        onTap: () => RepoDetailsRoute(repo.owner.login, repo.name).go(context),
        child: Row(
          children: [
            Text(repo.id.toString()),
            const SizedBox(width: 20),
            Text(repo.name),
          ],
        ),
      );
}
