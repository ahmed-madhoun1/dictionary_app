import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/utils/Constants.dart';
import '../models/word_definition.dart';
import 'dictionary_remote_data_source.dart';

part 'dictionary_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DictionaryApiService implements DictionaryRemoteDataSource {
  factory DictionaryApiService(Dio dio, {String baseUrl}) =
      _DictionaryApiService;

  @override
  @GET(ApiConstants.getWords)
  Future<WordListResponse> getWordDefinition(
    @Query(ApiConstants.getWordsQueryParam) String word,
    @Query('page') int page,
    @Query('page_size') int? pageSize,
  );
}
