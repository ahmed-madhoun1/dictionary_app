import 'package:dictionary_app/features/dictionary/domain/entities/word.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/word_definition.dart';

class WordDefinitionCard extends StatelessWidget {
  final Word wordEntry;
  final int index;

  const WordDefinitionCard({
    super.key,
    required this.wordEntry,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    wordEntry.word,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                if (wordEntry.partOfSpeech.isNotEmpty)
                  Chip(
                    label: Text(
                      wordEntry.partOfSpeech,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.book, size: 20, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    wordEntry.definition,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (wordEntry.exampleSentences.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.format_quote, size: 20, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Example: ${wordEntry.exampleSentences}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            if (wordEntry.exampleSentences.isNotEmpty) const SizedBox(height: 12),
            if (wordEntry.synonyms.isNotEmpty || wordEntry.antonyms.isNotEmpty)
              ExpansionTile(
                title: Text(
                  'Synonyms & Antonyms',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                children: [
                  if (wordEntry.synonyms.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.add_circle, size: 20, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Synonyms:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  wordEntry.synonyms.join(', '),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (wordEntry.antonyms.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.remove_circle, size: 20, color: Theme.of(context).colorScheme.error),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Antonyms:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  wordEntry.antonyms.join(', '),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}