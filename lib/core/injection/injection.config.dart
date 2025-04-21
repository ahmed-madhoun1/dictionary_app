// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/dictionary/data/datasources/dictionary_api_service.dart'
    as _i90;
import '../../features/dictionary/di/dictionary_module.dart' as _i982;
import '../../features/dictionary/domain/repositories/dictionary_repository.dart'
    as _i574;
import '../../features/dictionary/domain/usecases/get_word_definition.dart'
    as _i787;
import '../../features/dictionary/presentation/bloc/dictionary_bloc.dart'
    as _i928;
import '../network/network_info.dart' as _i932;
import 'network_module.dart' as _i567;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final networkModule = _$NetworkModule();
  final dictionaryModule = _$DictionaryModule();
  gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
  gh.lazySingleton<_i932.NetworkInfo>(() => networkModule.networkInfo);
  gh.lazySingleton<_i90.DictionaryApiService>(
      () => dictionaryModule.dictionaryApiService);
  gh.lazySingleton<_i574.DictionaryRepository>(
      () => dictionaryModule.dictionaryRepository);
  gh.lazySingleton<_i787.GetWordDefinition>(
      () => dictionaryModule.getWordDefinition);
  gh.lazySingleton<_i928.DictionaryBloc>(() => dictionaryModule.dictionaryBloc);
  return getIt;
}

class _$NetworkModule extends _i567.NetworkModule {}

class _$DictionaryModule extends _i982.DictionaryModule {}
