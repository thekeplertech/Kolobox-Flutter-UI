import '../../../core/apirepo/base_api_repo.dart';
import '../../../core/http/network_infoccess.dart';

abstract class SplashRepo extends BaseApiRepo {
  SplashRepo(NetworkInfo? networkInfo) : super(networkInfo);
}
