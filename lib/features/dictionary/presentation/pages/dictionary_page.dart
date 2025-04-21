import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../l10n/app_localizations.dart';
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
        title: Text(
          'Dictionary',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WordSearchBar(
              controller: TextEditingController(),
              onSearch: (query) {
                final trimmedWord = query.trim();
                if (trimmedWord.isNotEmpty) {
                  pagingController.refresh();
                  context
                      .read<DictionaryBloc>()
                      .add(GetWordDefinitionEvent(trimmedWord));
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<DictionaryBloc, DictionaryState>(
                listener: (context, state) {
                  if (state is DictionaryLoaded) {
                    if (state.allEntries.isEmpty) {
                      pagingController.error =
                          AppLocalizations.of(context).noResultsFound;
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
                    return Center(
                        child: Text(
                            AppLocalizations.of(context).enterAWordToSearch));
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
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child:
                            Text(AppLocalizations.of(context).noResultsFound),
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
