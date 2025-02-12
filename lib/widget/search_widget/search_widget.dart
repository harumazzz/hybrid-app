import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.onChange,
  });

  final TextEditingController controller;

  final void Function() onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search...',
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Symbols.clear),
              onPressed: () => controller.clear(),
            ),
            IconButton(
              icon: Icon(Symbols.search),
              onPressed: () {
                context.read<ProductBloc>().add(const ProductClearEvent());
                context.read<ProductBloc>().add(ProductSearchEvent(prefix: controller.text));
              },
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
