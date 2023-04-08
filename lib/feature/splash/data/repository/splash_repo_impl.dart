import '../../../../core/http/network_info.dart';
import '../../domain/splash_repo.dart';
import '../data_source/remote_fetch_users_data_source.dart';

class SplashRepoImpl extends SplashRepo {
  final RemoteFetchUsersDataSource? remoteFetchUsersRepo;

  SplashRepoImpl(
    NetworkInfo networkInfo, {
    required this.remoteFetchUsersRepo,
  }) : super(networkInfo);
}
