import 'package:equatable/equatable.dart';

import 'repo_list_item_model.dart';

class ReposListModel extends Equatable {
  final int totalCount;
  final List<RepoListItemModel> items;

  const ReposListModel({required this.totalCount, required this.items});

  @override
  List<Object?> get props => [totalCount, items];
}
