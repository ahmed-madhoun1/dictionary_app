import 'package:dartz/dartz.dart';
import 'package:dictionary_app/core/error/failures.dart';
import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';

abstract class DictionaryRepository {
  Future<Either<Failure, PaginatedWords>> getWordDefinition(
    String word, {
    int page = 1,
    int? pageSize,
  });
}
