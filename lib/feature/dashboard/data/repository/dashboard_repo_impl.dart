import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/feature/dashboard/data/data_source/remote_dashboard_data_source.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';
import 'package:kolobox_new_app/feature/home/data/models/wallet_data_model.dart';

import '../../../../../core/http/network_info.dart';
import '../../../../../core/models/failure.dart';
import '../../../../../core/models/success.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/preference/pref_helper.dart';
import '../models/profile_data_model.dart';

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
    await helper.setProfileDataModel(model);
    return Right(Success(model));
  }
}
