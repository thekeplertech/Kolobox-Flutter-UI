import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/data_source/remote_forget_password_data_source.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/domain/forget_password_repo.dart';
import 'package:kolobox_new_app/feature/auth/login/data/data_source/remote_login_data_source.dart';
import 'package:kolobox_new_app/feature/auth/register/data/data_source/remote_register_data_source.dart';
import 'package:kolobox_new_app/feature/auth/register/data/data_source/remote_register_data_source_impl.dart';
import 'package:kolobox_new_app/feature/auth/register/data/repository/register_repo_impl.dart';
import 'package:kolobox_new_app/feature/auth/register/domain/register_repo.dart';
import 'package:kolobox_new_app/feature/dashboard/data/data_source/remote_dashboard_data_source.dart';
import 'package:kolobox_new_app/feature/dashboard/data/data_source/remote_dashboard_data_source_impl.dart';
import 'package:kolobox_new_app/feature/dashboard/data/repository/dashboard_repo_impl.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';
import 'package:logger/logger.dart';

import '../core/apirepo/custom_interceptors.dart';
import '../core/http/network_info.dart';
import '../core/http/network_info_impl.dart';
import '../core/http/rest_client.dart';
import '../core/http/rest_client_impl.dart';
import '../core/loggers/app_log_filter.dart';
import '../core/loggers/app_log_printer.dart';
import '../core/preference/pref_helper.dart';
import '../core/preference/pref_helper_impl.dart';
import '../feature/auth/forget_password/data/data_source/remote_forget_password_data_source_impl.dart';
import '../feature/auth/forget_password/data/repository/forget_password_repo_impl.dart';
import '../feature/auth/login/data/data_source/remote_login_data_source_impl.dart';
import '../feature/auth/login/data/repository/login_repo_impl.dart';
import '../feature/auth/login/domain/login_repo.dart';
import '../feature/splash/data/data_source/remote_fetch_users_data_source.dart';
import '../feature/splash/data/data_source/remote_fetch_users_data_source_impl.dart';
import '../feature/splash/data/repository/splash_repo_impl.dart';
import '../feature/splash/domain/splash_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Configuration injection
  sl.registerLazySingleton<PrefHelper>(() => PrefHelperImpl());
  sl.registerLazySingleton<Logger>(() =>
      Logger(filter: AppLogFilter(), printer: AppLogPrinter(prefHelper: sl())));
  Dio dio = Dio();
  dio.interceptors.add(CustomInterceptors());
  sl.registerSingleton<Dio>(dio);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<RestClient>(() => RestClientImpl(dioClient: sl()));

  // Some initialization
  // sl.registerLazySingleton<MessageDataSource>(
  //     () => FirebaseMessageDataSourceImpl());

  // sl.registerSingleton<PayStackPayment>(PayStackPayment());

  // Some API Repositories
  sl.registerLazySingleton<SplashRepo>(
      () => SplashRepoImpl(sl(), remoteFetchUsersRepo: sl()));
  sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(sl()));
  sl.registerLazySingleton<ForgetPasswordRepo>(
      () => ForgetPasswordRepoImpl(sl()));
  sl.registerLazySingleton<RegisterRepo>(() => RegisterRepoImpl(sl()));
  sl.registerLazySingleton<DashboardRepo>(() => DashboardRepoImpl(sl()));

  // Some data sources
  sl.registerLazySingleton<RemoteFetchUsersDataSource>(
      () => RemoteFetchUsersDataSourceImpl(restClient: sl()));
  sl.registerLazySingleton<RemoteLoginDataSource>(
      () => RemoteLoginDataSourceImpl(restClient: sl()));
  sl.registerLazySingleton<RemoteForgetPasswordDataSource>(
      () => RemoteForgetPasswordDataSourceImpl(restClient: sl()));
  sl.registerLazySingleton<RemoteRegisterDataSource>(
      () => RemoteRegisterDataSourceImpl(restClient: sl()));
  sl.registerLazySingleton<RemoteDashboardDataSource>(
      () => RemoteDashboardDataSourceImpl(restClient: sl()));
}
