import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/cubit/cubit/product_cubit.dart';
import 'package:hybrid_app/widget/list/list_product.dart';
import 'package:hybrid_app/util/dialog_helper.dart';
import 'package:hybrid_app/widget/loading/loading_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildList() {
    return Expanded(
      child: ListProduct(
        onChange: (cubit) async {
          return await cubit.loadProducts();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => BlocConsumer<ProductCubit, ProductState>(
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
          } else {
            return _buildList();
          }
        },
      ),
    );
  }
}
