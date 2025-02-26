import 'package:flutter/material.dart';
import 'package:hybrid_app/extension/localization.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  final TextEditingController controller;

  final void Function(String value) onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onSearch,
      decoration: InputDecoration(
        hintText: '${context.localization.search}...',
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Symbols.clear),
              onPressed: () => controller.clear(),
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
