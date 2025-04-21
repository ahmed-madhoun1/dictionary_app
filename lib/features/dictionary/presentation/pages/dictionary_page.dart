import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/models/word_definition.dart';
import '../bloc/dictionary_bloc.dart';
import '../widgets/word_search_bar.dart';
import '../widgets/word_definition_card.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pagingController = PagingController<int, Word>(firstPageKey: 1);

    pagingController.addPageRequestListener((pageKey) {
      context.read<DictionaryBloc>().add(const LoadMoreWords());
    });

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: WordSearchBar(
            controller: TextEditingController(),
            onSearch: (query) {
              final trimmedWord = query.trim();
              if (trimmedWord.isNotEmpty) {
                pagingController.refresh();
                context.read<DictionaryBloc>().add(GetWordDefinitionEvent(trimmedWord));
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<DictionaryBloc, DictionaryState>(
                listener: (context, state) {
                  if (state is DictionaryLoaded) {
                    if (state.allEntries.isEmpty) {
                      pagingController.error = 'No results found';
                    } else {
                      pagingController.appendPage(
                        state.paginatedWords.words,
                        state.hasReachedEnd
                            ? null
                            : pagingController.nextPageKey! + 1,
                      );
                    }
                  } else if (state is DictionaryError) {
                    pagingController.error = state.message;
                  }
                },
                builder: (context, state) {
                  if (state is DictionaryInitial) {
                    return const Center(child: Text('Enter a word to search'));
                  }
                  return PagedListView<int, Word>(
                    pagingController: pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Word>(
                      itemBuilder: (context, item, index) => WordDefinitionCard(
                        wordEntry: item,
                        index: index,
                      ),
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: Text(pagingController.error.toString()),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => const Center(
                        child: Text('No results found'),
                      ),
                      firstPageProgressIndicatorBuilder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
