import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/list_page_loading_indicator.dart';
import '../../../../../translations/translations.gl.dart';
import '../../../domain/models/pull_model.dart';
import '../cubit/repo_pulls_cubit.dart';

class RepoPullsBody extends StatefulWidget {
  final List<PullModel> pulls;
  final bool isLoadingMore;

  const RepoPullsBody(this.pulls, {this.isLoadingMore = false, super.key});

  @override
  State<RepoPullsBody> createState() => _RepoPullsBodyState();
}

class _RepoPullsBodyState extends State<RepoPullsBody> {
  late final ScrollController _scrollController;
  late final Function() _loadMoreControllerListener;

  @override
  void initState() {
    super.initState();
    _loadMoreControllerListener = () {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0) {
        BlocProvider.of<RepoPullsCubit>(context).getMorePulls();
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
  Widget build(BuildContext context) => widget.pulls.isNotEmpty
      ? RefreshIndicator(
          onRefresh: () => BlocProvider.of<RepoPullsCubit>(context).getPulls(),
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 10),
            itemCount: widget.pulls.length,
            itemBuilder: (context, index) => index == widget.pulls.length - 1
                ? Column(
                    children: [
                      _buildItem(context, widget.pulls[index]),
                      ListPageLoadingIndicator(isLoading: widget.isLoadingMore),
                    ],
                  )
                : _buildItem(context, widget.pulls[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
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
