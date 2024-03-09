import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../translations/translations.gl.dart';
import '../../../domain/models/pull_model.dart';

class RepoPullsBody extends StatelessWidget {
  final List<PullModel> pulls;

  const RepoPullsBody(this.pulls, {super.key});

  @override
  Widget build(BuildContext context) => pulls.isNotEmpty
      ? ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          itemCount: pulls.length,
          itemBuilder: (context, index) =>
              _buildRepoItem(context, pulls[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        )
      : Text(LocaleKeys.repo_pulls_empty.tr());

  Widget _buildRepoItem(BuildContext context, PullModel pull) => Row(
        children: [
          Text(pull.number.toString()),
          const SizedBox(width: 20),
          Text(pull.title),
        ],
      );
}
