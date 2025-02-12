import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/screen/home/home_screen.dart';
import 'package:hybrid_app/screen/search/search_page.dart';
import 'package:material_symbols_icons/symbols.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  void _onSearch(BuildContext context) {
    context.read<ProductBloc>().add(const ProductClearEvent());
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
        title: Text('Hybrid App'),
        actions: [
          IconButton(
            onPressed: () => _onSearch(context),
            icon: const Icon(Symbols.search),
          ),
        ],
      ),
      body: HomeScreen(),
    );
  }
}
