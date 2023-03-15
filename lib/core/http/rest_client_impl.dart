import 'package:dio/dio.dart';

import '../../config/flavor_config.dart';
import '../../di/injection_container.dart';
import '../preference/pref_helper.dart';
import 'api_constants.dart';
import 'rest_client.dart';
import 'rest_helper.dart';

class RestClientImpl implements RestClient {
  RestClientImpl({required this.dioClient});

  final Dio dioClient;

  @override
  Future<RestHelper> getClient({bool isOptional = false}) async {
    dioClient.options.baseUrl = !isOptional
        ? FlavorConfig.instance!.baseUrl
        : 'https://api.solarweb.com/swqapi/';
    PrefHelper? helper = sl();

    Map<String, dynamic> headersMap = {
      'Content-Type': 'application/json',
    };

    headersMap.putIfAbsent('Authorization',
        () => 'Bearer ${helper.getLoginResponseModel().token}');
    // headersMap.putIfAbsent(
    //     'AccessKeyId', () => 'FKIA8DEC740217144A779ADD787C07A3A6AA');
    // headersMap.putIfAbsent(
    //     'AccessKeyValue', () => 'f45b03ec-82c3-48b7-b7e4-67fc815296e1');

    dioClient.options.headers = headersMap;

    dioClient.options.connectTimeout = API_CONNECT_TIMEOUT;
    dioClient.options.receiveTimeout = RECEIVE_TIMEOUT;
    return RestHelper(dioClient);
  }

  Future<void> attachCertificate(
      {required bool isInfinite,
      bool isContentPages = false,
      bool isMultipart = false,
      Map<String, dynamic>? extraHeaders}) async {
    // Settings SSL Pinning Certificate
    // SecurityContext clientContext = SecurityContext(withTrustedRoots: false);
    // var certificate = (await rootBundle.load(FlavorConfig.instance!.cert_path))
    //     .buffer
    //     .asInt8List();
    // clientContext.setTrustedCertificatesBytes(certificate);
    // (dioClient.httpClientAdapter as DefaultHttpClientAdapter)
    //         .onHttpClientCreate =
    //     (HttpClient client) => HttpClient(context: clientContext);
  }
}
