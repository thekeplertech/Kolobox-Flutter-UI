import '../../../core/apirepo/base_api_repo.dart';
import '../../../core/http/network_info.dart';

abstract class SplashRepo extends BaseApiRepo {
  SplashRepo(NetworkInfo? networkInfo) : super(networkInfo);
}
