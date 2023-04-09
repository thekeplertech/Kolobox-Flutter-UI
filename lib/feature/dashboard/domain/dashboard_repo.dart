import 'package:dartz/dartz.dart';

import '../../../../core/apirepo/base_api_repo.dart';
import '../../../../core/http/network_info.dart';
import '../../../../core/models/failure.dart';
import '../../../../core/models/success.dart';
import '../data/models/earnings_request_model.dart';
import '../data/models/transactions_request_model.dart';

abstract class DashboardRepo extends BaseApiRepo {
  DashboardRepo(NetworkInfo? networkInfo) : super(networkInfo);

  Future<Either<Failure, Success>> wallet();

  Future<Either<Failure, Success>> getProfile();

  Future<Either<Failure, Success>> getProducts();

  Future<Either<Failure, Success>> getActiveProducts();

  Future<Either<Failure, Success>> getEarnings(EarningsRequestModel model);

  Future<Either<Failure, Success>> getTransactions(
      TransactionsRequestModel model);
}
