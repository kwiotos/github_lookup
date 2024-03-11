import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../translations/translations.gl.dart';
import '../../../domain/models/repo_details_model.dart';
import '../../../domain/models/user_model.dart';
import '../../repo_pulls/route/repo_pulls_route.dart';
import '../../repos/route/repos_route.dart';

class RepoDetailsBody extends StatelessWidget {
  final RepoDetailsModel repo;

  const RepoDetailsBody(this.repo, {super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (repo.fullName != null) ...[
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        repo.fullName!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                  if (repo.description != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      repo.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 10),
                  _buildOwner(context, repo.owner),
                  const SizedBox(height: 10),
                  if (repo.stars != null) ...[
                    const SizedBox(height: 10),
                    _buildIconicInfo(
                      context,
                      icon: Icons.star_border_outlined,
                      info: plural(
                        LocaleKeys.repo_details_stars,
                        repo.stars!,
                        args: ['${repo.stars!}'],
                      ),
                    ),
                  ],
                  if (repo.forks != null) ...[
                    const SizedBox(height: 10),
                    _buildIconicInfo(
                      context,
                      icon: Icons.account_tree_outlined,
                      info: plural(
                        LocaleKeys.repo_details_forks,
                        repo.forks!,
                        args: ['${repo.forks!}'],
                      ),
                    ),
                  ],
                  if (repo.subscribers != null) ...[
                    const SizedBox(height: 10),
                    _buildIconicInfo(
                      context,
                      icon: Icons.remove_red_eye_outlined,
                      info: plural(
                        LocaleKeys.repo_details_subscribers,
                        repo.subscribers!,
                        args: ['${repo.subscribers!}'],
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  if (repo.language != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.repo_details_language.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          repo.language!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.apply(fontWeightDelta: 2),
                        ),
                      ],
                    ),
                  ],
                  if (repo.topics.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      LocaleKeys.repo_details_related_topics.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      children: repo.topics
                          .map((e) => _buildTopic(context, e))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: () =>
                          RepoPullsRoute(repo.owner.login, repo.name).go(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            LocaleKeys.repo_details_show_pulls.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(color: Colors.blue, fontWeightDelta: 1),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _buildIconicInfo(
    BuildContext context, {
    required IconData icon,
    required String info,
  }) =>
      Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 5),
          Text(info, style: Theme.of(context).textTheme.labelLarge),
        ],
      );

  Widget _buildTopic(BuildContext context, String topic) => Container(
        margin: const EdgeInsets.only(right: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple),
        ),
        child: Text(
          topic,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.apply(color: Colors.deepPurple),
        ),
      );

  Widget _buildOwner(BuildContext context, UserModel owner) => Row(
        children: [
          Text(
            LocaleKeys.repo_details_maintained_by.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 20,
            child: Image.network(repo.owner.avatarUrl!),
          ),
          const SizedBox(width: 5),
          Text(owner.login, style: Theme.of(context).textTheme.labelLarge),
        ],
      );
}
