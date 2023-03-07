import 'package:dartz/dartz.dart';

import '../../../../core/http/network_info.dart';
import '../../../../core/models/failure.dart';
import '../../../../core/models/success.dart';
import '../../domain/splash_repo.dart';
import '../data_source/remote_fetch_users_data_source.dart';

class SplashRepoImpl extends SplashRepo {
  final RemoteFetchUsersDataSource? remoteFetchUsersRepo;

  SplashRepoImpl(
    NetworkInfo networkInfo, {
    required this.remoteFetchUsersRepo,
  }) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> fetchUsers() =>
      baseApiMethod(() => fetchUsersFromAPI());

  Future<Either<Failure, Success>> fetchUsersFromAPI() async {
    var response = await remoteFetchUsersRepo!.fetchUsers();
    Success dataModel = Success(response, message: response.message);
    return Right(dataModel);
    // if (!response.status!) {
    //   return Left(
    //       Failure(message: response.message, apiStatus: response.statusCode));
    // } else {
    //   Success dataModel = Success(null, message: response.message);
    //   return Right(dataModel);
    // }
  }
}
