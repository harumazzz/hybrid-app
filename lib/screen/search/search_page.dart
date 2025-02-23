import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/cubit/cubit/product_cubit.dart';
import 'package:hybrid_app/util/thread_helper.dart';
import 'package:hybrid_app/widget/list/list_product.dart';
import 'package:hybrid_app/util/dialog_helper.dart';
import 'package:hybrid_app/widget/loading/loading_widget.dart';
import 'package:hybrid_app/widget/search_widget/search_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  Timer? _debounce;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _dispose() async {
    popDialog() => Navigator.of(context).pop();
    context.read<ProductCubit>().clearProducts();
    await context.read<ProductCubit>().loadProducts();
    popDialog();
  }

  void _onSearch(String value) {
    _debounce?.cancel();
    _debounce = ThreadHelper.asNewInstance(
      milliseconds: 300,
      callback: () async {
        if (value.isNotEmpty) {
          context.read<ProductCubit>().clearProducts();
          await context.read<ProductCubit>().searchProducts(value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Symbols.arrow_back),
          onPressed: _dispose,
        ),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: SearchWidget(
              key: const Key('search_widget'),
              controller: _searchController,
              onSearch: _onSearch,
            ),
          ),
        ),
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) async {
          if (state is ProductError) {
            await DialogHelper.showErrorDialog(
              context: context,
              content: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is ProductInitial || state is ProductFirstLoading) {
            return const LoadingWidget();
          } else if (state is ProductClear) {
            return const SizedBox.shrink();
          } else {
            return ListProduct(
              onChange: (cubit) async {
                return await cubit.searchProducts(_searchController.text);
              },
            );
          }
        },
      ),
    );
  }
}
