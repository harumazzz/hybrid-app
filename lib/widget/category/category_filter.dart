import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/cubit/category_cubit/category_cubit.dart';
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
      onTap: (selectedItems) {
        final result = UiHelper.toItemList(selectedItems);
        _onTap(context, result[0].slug!);
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

  void _onTap(
    BuildContext context,
    String categoryId,
  ) {
    context.read<ProductBloc>().add(const ProductClearEvent());
    context.read<ProductBloc>().add(ProductFilterEvent(category: categoryId));
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
