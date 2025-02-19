import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/cubit/category_cubit/category_cubit.dart';
import 'package:hybrid_app/cubit/cubit/product_cubit.dart';
import 'package:hybrid_app/util/dialog_helper.dart';
import 'package:hybrid_app/util/modal_helper.dart';
import 'package:hybrid_app/util/ui_helper.dart';
import 'package:hybrid_app/widget/loading/loading_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  void _onShow({
    required BuildContext context,
    required CategoryLoaded state,
  }) {
    ModalHelper.showDropDownModal(
      context: context,
      data: UiHelper.makeDefaultItems(data: state.value.data!),
      onTap: (selectedItems) async {
        final result = UiHelper.toItemList(selectedItems);
        await _onTap(context, result[0].slug!);
      },
    );
  }

  Widget _buildCategoriesBox({
    required BuildContext context,
    required CategoryLoaded state,
  }) {
    return IconButton(
      icon: Icon(Symbols.category),
      onPressed: () => _onShow(context: context, state: state),
    );
  }

  Future<void> _onTap(
    BuildContext context,
    String categoryId,
  ) async {
    context.read<ProductCubit>().clearProducts();
    await context.read<ProductCubit>().filterProducts(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) async {
        if (state is CategoryLoadError) {
          await DialogHelper.showErrorDialog(
            context: context,
            content: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is CategoryInitial || state is CategoryLoad) {
          return const LoadingWidget();
        } else if (state is CategoryLoaded) {
          return _buildCategoriesBox(
            context: context,
            state: state,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
