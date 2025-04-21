import 'package:dartz/dartz.dart';
import 'package:dictionary_app/core/error/failures.dart';
import 'package:dictionary_app/core/usecase/usecase.dart';
import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';
import 'package:dictionary_app/features/dictionary/domain/repositories/dictionary_repository.dart';
import 'package:equatable/equatable.dart';

class GetWordDefinition implements UseCase<PaginatedWords, WordParams> {
  final DictionaryRepository repository;

  GetWordDefinition(this.repository);

  @override
  Future<Either<Failure, PaginatedWords>> call(WordParams params) async {
    return await repository.getWordDefinition(
      params.word,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class WordParams extends Equatable {
  final String word;
  final int page;
  final int? pageSize;

  const WordParams({
    required this.word,
    this.page = 1,
    this.pageSize,
  });

  @override
  List<Object?> get props => [word, page, pageSize];
}