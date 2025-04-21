import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dictionary_app/core/error/failures.dart';
import 'package:dictionary_app/core/network/network_info.dart';
import 'package:dictionary_app/core/utils/constants.dart';
import 'package:dictionary_app/features/dictionary/data/datasources/dictionary_remote_data_source.dart';
import 'package:dictionary_app/features/dictionary/data/models/word_definition.dart';
import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';
import 'package:dictionary_app/features/dictionary/domain/repositories/dictionary_repository.dart';

class DictionaryRepositoryImpl implements DictionaryRepository {
  final DictionaryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DictionaryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PaginatedWords>> getWordDefinition(
      String word, {
        int page = 1,
        int? pageSize,
      }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.getWordDefinition(
        word,
        page,
        pageSize,
      );
      if (result.statusCode != 200 || result.errors.isNotEmpty) {
        return Left(ServerFailure());
      }
      return Right(_mapToDomain(result));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left(InvalidInputFailure());
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  PaginatedWords _mapToDomain(WordListResponse response) {
    return PaginatedWords(
      count: response.result.count,
      next: response.result.next,
      previous: response.result.previous,
      words: response.result.results
          .map((entry) => Word(
        id: entry.id,
        word: entry.word,
        definition: entry.definition,
        partOfSpeech: entry.partOfSpeech,
        exampleSentences: entry.exampleSentences,
        synonyms: entry.synonyms,
        antonyms: entry.antonyms,
      ))
          .toList(),
    );
  }
}