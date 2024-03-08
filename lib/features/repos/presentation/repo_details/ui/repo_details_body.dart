import 'package:flutter/cupertino.dart';

import '../../../domain/models/repo_details_model.dart';

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
        ],
      );
}
