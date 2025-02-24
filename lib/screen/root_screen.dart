import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/cubit/cubit/product_cubit.dart';
import 'package:hybrid_app/extension/localization.dart';
import 'package:hybrid_app/screen/home/home_screen.dart';
import 'package:hybrid_app/screen/search/search_page.dart';
import 'package:hybrid_app/widget/category/category_filter.dart';
import 'package:material_symbols_icons/symbols.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  void _onSearch(BuildContext context) {
    context.read<ProductCubit>().clearProducts();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SearchPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.title),
        actions: [
          IconButton(
            key: const Key('search_button'),
            onPressed: () => _onSearch(context),
            icon: const Icon(Symbols.search),
          ),
          CategoryFilter(),
        ],
      ),
      body: HomeScreen(),
    );
  }
}
