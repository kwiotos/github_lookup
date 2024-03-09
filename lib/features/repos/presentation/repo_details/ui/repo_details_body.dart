import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../translations/translations.gl.dart';
import '../../../domain/models/repo_details_model.dart';
import '../../repo_pulls/route/repo_pulls_route.dart';
import '../../repos/route/repos_route.dart';

class RepoDetailsBody extends StatelessWidget {
  final RepoDetailsModel repo;

  const RepoDetailsBody(this.repo, {super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(repo.name),
          if (repo.fullName != null) ...[
            const SizedBox(height: 10),
            Text(repo.fullName!),
          ],
          InkWell(
            onTap: () =>
                RepoPullsRoute(repo.owner.login, repo.name).go(context),
            child: Text(LocaleKeys.repo_details_show_pulls.tr()),
          ),
        ],
      );
}
