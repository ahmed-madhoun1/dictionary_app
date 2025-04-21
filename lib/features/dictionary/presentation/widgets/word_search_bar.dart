import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordSearchBar extends StatelessWidget {
  final TextEditingController controller;

  final Function(dynamic query) onSearch;

  const WordSearchBar({super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search for a word',
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => onSearch(controller.text),
            ),
          ],
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onSubmitted: (word) => onSearch(word),
    );
  }
}
