import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/screen/detail/detail_screen.dart';
import 'package:hybrid_app/widget/product_item/product_item_widget.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({
    super.key,
    required this.onEvent,
  });

  final ProductEvent Function() onEvent;

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late ScrollController _scrollController;

  late bool _hasListener;

  @override
  void initState() {
    _scrollController = ScrollController();
    _hasListener = true;
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final productBloc = context.read<ProductBloc>();
      if (productBloc.state is! ProductLoading && productBloc.state is! ProductFull) {
        productBloc.add(widget.onEvent());
      }
    }
  }

  @override
  void dispose() {
    if (_hasListener) {
      _scrollController.removeListener(_onScroll);
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onMove(
    BuildContext context,
    Product product,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductFull) {
          _scrollController.removeListener(_onScroll);
          _hasListener = false;
        }
      },
      builder: (context, state) {
        return ListView.builder(
          // preserve the page
          key: PageStorageKey('list-product'),
          controller: _scrollController,
          itemCount: state.productList.size,
          itemBuilder: (context, index) {
            final product = state.productList[index];
            return ProductItemWidget(
              product: product,
              onMove: (context) => _onMove(context, state.productList[index]),
            );
          },
        );
      },
    );
  }
}
