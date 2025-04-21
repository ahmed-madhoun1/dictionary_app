import 'package:equatable/equatable.dart';

class PaginatedWords extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<Word> words;

  const PaginatedWords({
    required this.count,
    required this.next,
    required this.previous,
    required this.words,
  });

  @override
  List<Object?> get props => [count, next, previous, words];
}

class Word extends Equatable {
  final int? id;
  final String word;
  final String definition;
  final String partOfSpeech;
  final String exampleSentences;
  final List<String> synonyms;
  final List<String> antonyms;

  const Word({
    this.id,
    required this.word,
    required this.definition,
    required this.partOfSpeech,
    required this.exampleSentences,
    required this.synonyms,
    required this.antonyms,
  });

  @override
  List<Object?> get props => [
    id,
    word,
    definition,
    partOfSpeech,
    exampleSentences,
    synonyms,
    antonyms
  ];
}