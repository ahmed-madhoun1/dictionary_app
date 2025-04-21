import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dictionary_app/core/error/failures.dart';
import 'package:dictionary_app/core/network/network_info.dart';
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
      final result = await remoteDataSource.getWordDefinition(word, page, pageSize,);
      if (result.statusCode != 200 || result.errors.isNotEmpty) {
        return Left(ServerFailure());
      }
      return Right(mapToDomain(result));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left(InvalidInputFailure());
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }


}