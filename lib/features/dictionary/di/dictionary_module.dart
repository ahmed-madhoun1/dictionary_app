import 'package:dictionary_app/core/network/network_info.dart';
import 'package:dictionary_app/core/utils/Constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dictionary_app/features/dictionary/data/datasources/dictionary_api_service.dart';
import 'package:dictionary_app/features/dictionary/data/repositories/dictionary_repository_impl.dart';
import 'package:dictionary_app/features/dictionary/domain/repositories/dictionary_repository.dart';
import 'package:dictionary_app/features/dictionary/domain/usecases/get_word_definition.dart';
import 'package:dictionary_app/features/dictionary/presentation/bloc/dictionary_bloc.dart';

import '../../../core/injection/injection.dart';

@module
abstract class DictionaryModule {
  @lazySingleton
  DictionaryApiService get dictionaryApiService => DictionaryApiService(
        Dio(),
        baseUrl: ApiConstants.baseUrl,
      );

  @lazySingleton
  DictionaryRepository get dictionaryRepository => DictionaryRepositoryImpl(
      remoteDataSource: getIt<DictionaryApiService>(),
      networkInfo: getIt<NetworkInfo>());

  @lazySingleton
  GetWordDefinition get getWordDefinition =>
      GetWordDefinition(getIt<DictionaryRepository>());

  @lazySingleton
  DictionaryBloc get dictionaryBloc =>
      DictionaryBloc(getIt<GetWordDefinition>());
}
