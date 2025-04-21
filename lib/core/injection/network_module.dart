import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dictionary_app/core/network/network_info.dart';

import 'injection.dart';


@module
abstract class NetworkModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  NetworkInfo get networkInfo => NetworkInfoImpl(getIt<Connectivity>());
}
