import 'package:dartz/dartz.dart';

import '../../../../core/apirepo/base_api_repo.dart';
import '../../../../core/http/network_info.dart';
import '../../../../core/models/failure.dart';
import '../../../../core/models/success.dart';

abstract class DashboardRepo extends BaseApiRepo {
  DashboardRepo(NetworkInfo? networkInfo) : super(networkInfo);

  Future<Either<Failure, Success>> wallet();
}
