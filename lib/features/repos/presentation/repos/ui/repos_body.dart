import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/focus_utils.dart';
import '../../../../../core/widgets/list_page_loading_indicator.dart';
import '../../../../../translations/translations.gl.dart';
import '../../../domain/models/repo_list_item_model.dart';
import '../../../domain/models/repos_list_model.dart';
import '../../repo_details/route/repo_details_route.dart';
import '../cubit/repos_cubit.dart';
import '../route/repos_route.dart';

class ReposBody extends StatefulWidget {
  final ReposListModel repos;
  final bool isLoadingMore;

  const ReposBody(this.repos, {this.isLoadingMore = false, super.key});

  @override
  State<ReposBody> createState() => _ReposBodyState();
}

class _ReposBodyState extends State<ReposBody> {
  late final ScrollController _scrollController;
  late final Function() _loadMoreControllerListener;

  @override
  void initState() {
    super.initState();
    _loadMoreControllerListener = () {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0) {
        BlocProvider.of<ReposCubit>(context).getMoreRepos();
      }
    };
    _scrollController = ScrollController()
      ..addListener(_loadMoreControllerListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreControllerListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 10),
        itemCount: widget.repos.items.length,
        itemBuilder: (context, index) => index == 0
            ? _buildFirstItem(context, widget.repos.items[index])
            : index == widget.repos.items.length - 1
                ? _buildLastItem(context, widget.repos.items[index])
                : _buildItem(context, widget.repos.items[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );

  Widget _buildFirstItem(BuildContext context, RepoListItemModel repo) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plural(
              LocaleKeys.repos_results_count,
              widget.repos.totalCount,
              args: ['${widget.repos.totalCount}'],
            ),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 10),
          _buildItem(context, repo),
        ],
      );

  Widget _buildLastItem(BuildContext context, RepoListItemModel repo) => Column(
        children: [
          _buildItem(context, repo),
          ListPageLoadingIndicator(isLoading: widget.isLoadingMore),
        ],
      );

  Widget _buildItem(BuildContext context, RepoListItemModel repo) => InkWell(
        onTap: () {
          FocusUtils.hideKeyboard(context);
          RepoDetailsRoute(repo.owner.login, repo.name).go(context);
        },
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
      );
}
