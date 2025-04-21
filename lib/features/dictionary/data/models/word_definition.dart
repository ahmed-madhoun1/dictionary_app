import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../data/models/word_definition.g.dart';

@JsonSerializable()
class PaginatedWordResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<WordEntry> results;

  const PaginatedWordResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PaginatedWordResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedWordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedWordResponseToJson(this);
}

@JsonSerializable()
class WordListResponse extends Equatable {
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final List<String> errors;
  final PaginatedWordResponse result;

  const WordListResponse({
    required this.statusCode,
    required this.message,
    required this.errors,
    required this.result,
  });

  factory WordListResponse.fromJson(Map<String, dynamic> json) =>
      _$WordListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WordListResponseToJson(this);

  @override
  List<Object?> get props => [statusCode, message, errors, result];
}

@JsonSerializable()
class WordEntry extends Equatable {
  final int? id;
  final String word;
  final String definition;
  @JsonKey(name: 'part_of_speech')
  final String partOfSpeech;
  @JsonKey(name: 'example_sentences')
  final String exampleSentences;
  @JsonKey(fromJson: _listFromString, toJson: _stringFromList)
  final List<String> synonyms;
  @JsonKey(fromJson: _listFromString, toJson: _stringFromList)
  final List<String> antonyms;

  const WordEntry({
    this.id,
    required this.word,
    required this.definition,
    required this.partOfSpeech,
    required this.exampleSentences,
    required this.synonyms,
    required this.antonyms,
  });

  factory WordEntry.fromJson(Map<String, dynamic> json) =>
      _$WordEntryFromJson(json);
  Map<String, dynamic> toJson() => _$WordEntryToJson(this);

  static List<String> _listFromString(String str) =>
      str.isNotEmpty ? str.split('; ').map((s) => s.trim()).toList() : [];

  static String _stringFromList(List<String> list) => list.join('; ');

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
