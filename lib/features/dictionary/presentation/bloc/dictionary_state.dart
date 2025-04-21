part of 'dictionary_bloc.dart';

abstract class DictionaryState extends Equatable {
  const DictionaryState();

  @override
  List<Object> get props => [];
}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoading extends DictionaryState {}

class DictionaryLoaded extends DictionaryState {
  final String word;
  final PaginatedWords paginatedWords;
  final List<Word> allEntries;
  final int currentPage;
  final bool hasReachedEnd;

  const DictionaryLoaded({
    required this.word,
    required this.paginatedWords,
    required this.allEntries,
    required this.currentPage,
    required this.hasReachedEnd,
  });

  @override
  List<Object> get props =>
      [word, paginatedWords, allEntries, currentPage, hasReachedEnd];
}

class DictionaryError extends DictionaryState {
  final String message;

  const DictionaryError(this.message);

  @override
  List<Object> get props => [message];
}