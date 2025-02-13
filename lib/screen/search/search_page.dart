import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
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

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _dispose() {
    context.read<ProductBloc>().add(const ProductClearEvent());
    context.read<ProductBloc>().add(const ProductLoadEvent());
    Navigator.of(context).pop();
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
              controller: _searchController,
            ),
          ),
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
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
              onEvent: () {
                return ProductSearchEvent(
                  prefix: _searchController.text,
                );
              },
            );
          }
        },
      ),
    );
  }
}
