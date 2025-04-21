part of 'dictionary_bloc.dart';


abstract class DictionaryEvent extends Equatable {
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class GetWordDefinitionEvent extends DictionaryEvent {
  final String word;

  const GetWordDefinitionEvent(this.word);

  @override
  List<Object> get props => [word];
}

class LoadMoreWords extends DictionaryEvent {
  const LoadMoreWords();
}