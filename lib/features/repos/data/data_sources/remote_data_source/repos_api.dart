import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/config/app_constants.dart';
import '../../dtos/get_repos_result_dto.dart';
import '../../dtos/pull_dto.dart';
import '../../dtos/repo_details_dto.dart';

part 'repos_api.g.dart';

@injectable
@RestApi()
abstract class ReposApi {
  @factoryMethod
  factory ReposApi(
    Dio dio, {
    @Named(githubApiBaseUrlKey) String baseUrl,
  }) = _ReposApi;

  @GET(searchReposEndpoint)
  Future<GetReposResultDto> getRepos(@Query('q') String phrase);

  @GET(getRepoEndpoint)
  Future<RepoDetailsDto> getRepo(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );

  @GET(getRepoPRsEndpoint)
  Future<List<PullDto>> getRepoPulls(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );
}
