import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
          itemBuilder: (context, index) => _buildItem(context, pulls[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        )
      : Text(LocaleKeys.repo_pulls_empty.tr());

  Widget _buildItem(BuildContext context, PullModel pull) => Container(
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
                const Icon(
                  Icons.rebase_edit,
                  size: 20,
                  color: Colors.green,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    pull.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('#${pull.number}'),
                const SizedBox(width: 10),
                Text(
                  '${LocaleKeys.repo_pulls_created_at.tr()} ${DateFormat.yMd().format(pull.createdAt)}',
                ),
              ],
            ),
          ],
        ),
      );
}
