import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:dictionary_app/core/error/failures.dart';
import 'package:dictionary_app/features/dictionary/domain/usecases/get_word_definition.dart';
import '../../domain/entities/word.dart';

part 'dictionary_event.dart';

part 'dictionary_state.dart';

/// Manages dictionary-related state and events.
class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final GetWordDefinition getWordDefinition;

  DictionaryBloc(this.getWordDefinition) : super(DictionaryInitial()) {
    on<GetWordDefinitionEvent>(_onGetWordDefinition);
    on<LoadMoreWords>(_onLoadMoreWords);
  }

  /// Handles initial word search events, resetting pagination.
  Future<void> _onGetWordDefinition(
    GetWordDefinitionEvent event,
    Emitter<DictionaryState> emit,
  ) async {
    emit(DictionaryLoading());
    final result = await getWordDefinition(WordDefinitionParams(
      word: event.word,
      page: 1,
      pageSize: 10,
    ));

    emit(result.fold(
      (failure) => DictionaryError(_mapFailureToMessage(failure)),
      (paginatedWords) => DictionaryLoaded(
        word: event.word,
        allEntries: paginatedWords.words,
        paginatedWords: paginatedWords,
        currentPage: 1,
        hasReachedEnd: paginatedWords.next == null,
      ),
    ));
  }

  /// Handles loading more words for pagination.
  Future<void> _onLoadMoreWords(
    LoadMoreWords event,
    Emitter<DictionaryState> emit,
  ) async {
    final currentState = state;
    if (currentState is DictionaryLoaded && !currentState.hasReachedEnd) {
      final result = await getWordDefinition(WordDefinitionParams(
        word: currentState.word,
        page: currentState.currentPage + 1,
        pageSize: 10,
      ));

      emit(result.fold(
        (failure) => DictionaryError(_mapFailureToMessage(failure)),
        (paginatedWords) {
          final updatedEntries = [
            ...currentState.allEntries,
            ...paginatedWords.words
          ];
          return DictionaryLoaded(
            word: currentState.word,
            allEntries: updatedEntries,
            paginatedWords: paginatedWords,
            currentPage: currentState.currentPage + 1,
            hasReachedEnd: paginatedWords.next == null,
          );
        },
      ));
    }
  }

  /// Maps failures to user-friendly error messages.
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'No internet connection. Please check your network.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      case InvalidInputFailure:
        return 'Invalid input. Please enter a valid word.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
