import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/widget/product_item/product_item_widget.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({
    super.key,
    required this.productList,
  });

  final ProductList productList;

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      context.read<ProductBloc>().add(const ProductLoadEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.productList.size,
      itemBuilder: (context, index) {
        return ProductItemWidget(
          product: widget.productList[index],
        );
      },
    );
  }
}
