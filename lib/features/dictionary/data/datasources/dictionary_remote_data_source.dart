import 'package:dictionary_app/features/dictionary/data/models/word_definition.dart';
import 'package:retrofit/http.dart';

abstract class DictionaryRemoteDataSource {
  Future<WordListResponse> getWordDefinition(
    String word,
    int page,
    int? pageSize,
  );
}
