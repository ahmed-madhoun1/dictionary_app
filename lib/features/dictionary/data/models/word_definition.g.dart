// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../data/models/word_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedWordResponse _$PaginatedWordResponseFromJson(
        Map<String, dynamic> json) =>
    PaginatedWordResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => WordEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedWordResponseToJson(
        PaginatedWordResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

WordListResponse _$WordListResponseFromJson(Map<String, dynamic> json) =>
    WordListResponse(
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      result: PaginatedWordResponse.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WordListResponseToJson(WordListResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'errors': instance.errors,
      'result': instance.result,
    };

WordEntry _$WordEntryFromJson(Map<String, dynamic> json) => WordEntry(
      id: (json['id'] as num?)?.toInt(),
      word: json['word'] as String,
      definition: json['definition'] as String,
      partOfSpeech: json['part_of_speech'] as String,
      exampleSentences: json['example_sentences'] as String,
      synonyms: WordEntry._listFromString(json['synonyms'] as String),
      antonyms: WordEntry._listFromString(json['antonyms'] as String),
    );

Map<String, dynamic> _$WordEntryToJson(WordEntry instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'definition': instance.definition,
      'part_of_speech': instance.partOfSpeech,
      'example_sentences': instance.exampleSentences,
      'synonyms': WordEntry._stringFromList(instance.synonyms),
      'antonyms': WordEntry._stringFromList(instance.antonyms),
    };
