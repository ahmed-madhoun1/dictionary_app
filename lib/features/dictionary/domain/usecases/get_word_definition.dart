import 'package:dartz/dartz.dart';
import 'package:dictionary_app/core/error/failures.dart';
import 'package:dictionary_app/core/usecase/usecase.dart';
import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';
import 'package:dictionary_app/features/dictionary/domain/repositories/dictionary_repository.dart';
import 'package:equatable/equatable.dart';

class GetWordDefinition implements UseCase<PaginatedWords, WordDefinitionParams> {
  final DictionaryRepository repository;

  GetWordDefinition(this.repository);

  @override
  Future<Either<Failure, PaginatedWords>> call(WordDefinitionParams params) async {
    return await repository.getWordDefinition(
      params.word,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class WordDefinitionParams extends Equatable {
  final String word;
  final int page;
  final int? pageSize;

  const WordDefinitionParams({
    required this.word,
    this.page = 1,
    this.pageSize,
  });

  @override
  List<Object?> get props => [word, page, pageSize];
}