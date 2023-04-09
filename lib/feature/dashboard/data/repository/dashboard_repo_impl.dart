import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/feature/dashboard/data/data_source/remote_dashboard_data_source.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';
import 'package:kolobox_new_app/feature/home/data/models/wallet_data_model.dart';

import '../../../../../core/http/network_info.dart';
import '../../../../../core/models/failure.dart';
import '../../../../../core/models/success.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/preference/pref_helper.dart';
import '../models/active_product_data_model.dart';
import '../models/earnings_request_model.dart';
import '../models/product_data_model.dart';
import '../models/profile_data_model.dart';
import '../models/transactions_request_model.dart';

class DashboardRepoImpl extends DashboardRepo {
  RemoteDashboardDataSource remoteDashboardDataSource = sl();

  DashboardRepoImpl(NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> wallet() =>
      baseApiMethod(() => walletFromAPI());

  Future<Either<Failure, Success>> walletFromAPI() async =>
      Right(Success(WalletDataModel.fromJson(
          (await remoteDashboardDataSource.wallet()).data)));

  @override
  Future<Either<Failure, Success>> getProfile() =>
      baseApiMethod(() => getProfileFromAPI());

  Future<Either<Failure, Success>> getProfileFromAPI() async {
    ProfileDataModel model = ProfileDataModel.fromJson(
        (await remoteDashboardDataSource.getProfile()).data);
    PrefHelper helper = sl();
    // await helper.setLoginResponseModel(LoginResponseModel(
    //   id: model.user?.id ?? '',
    //   active: model.user?.active ?? false,
    //   firstname: model.user?.firstname ?? '',
    //   lastname: model.user?.lastname ?? '',
    //   email: model.user?.email ?? '',
    //   dob: model.user?.dob ?? '',
    //   phone: model.user?.phone ?? '',
    //   occupation: model.user?.occupation ?? '',
    //   wallet: model.user?.wallet ?? '',
    //   school: '',
    //   number: model.user?.number ?? '',
    //   nextOfKin: model.user?.nextOfKin ?? '',
    //   referral: '',
    //   createdAt: model.user?.createdAt ?? '',
    //   updatedAt: model.user?.updatedAt ?? '',
    //   smsNotification: model.user?.smsNotification ?? false,
    //   emailNotification: model.user?.emailNotification ?? false,
    //   token: helper.getToken(),
    // ));
    await helper.setProfileDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getProducts() =>
      baseApiMethod(() => getProductsFromAPI());

  Future<Either<Failure, Success>> getProductsFromAPI() async {
    ProductDataModel model = ProductDataModel.fromJson(
        (await remoteDashboardDataSource.getProducts()).data);
    PrefHelper helper = sl();
    await helper.setProductDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getActiveProducts() =>
      baseApiMethod(() => getActiveProductsFromAPI());

  Future<Either<Failure, Success>> getActiveProductsFromAPI() async {
    ActiveProductDataModel model = ActiveProductDataModel.fromJson(
        (await remoteDashboardDataSource.getActiveProducts()).data);
    PrefHelper helper = sl();
    await helper.setActiveProductDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getEarnings(EarningsRequestModel model) =>
      baseApiMethod(() => getEarningsFromAPI(model));

  Future<Either<Failure, Success>> getEarningsFromAPI(
      EarningsRequestModel model) async {
    await remoteDashboardDataSource.getEarnings(model);
    // ActiveProductDataModel model = ActiveProductDataModel.fromJson(
    //     (await remoteDashboardDataSource.getEarnings(model)).data);
    // PrefHelper helper = sl();
    // await helper.setActiveProductDataModel(model);
    return Right(Success(null));
  }

  @override
  Future<Either<Failure, Success>> getTransactions(
          TransactionsRequestModel model) =>
      baseApiMethod(() => getTransactionsFromAPI(model));

  Future<Either<Failure, Success>> getTransactionsFromAPI(
          TransactionsRequestModel model) async =>
      Right(Success(TransactionsDataModel.fromJson(
          (await remoteDashboardDataSource.getTransactions(model)).data)));
}
