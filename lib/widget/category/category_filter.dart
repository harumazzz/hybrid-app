import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/category_bloc/category_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/model/category.dart';
import 'package:hybrid_app/util/dialog_helper.dart';
import 'package:hybrid_app/util/modal_helper.dart';
import 'package:hybrid_app/util/ui_helper.dart';
import 'package:hybrid_app/widget/loading/loading_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  Widget _buildCategoriesBox({
    required BuildContext context,
    required CategoryLoaded state,
  }) {
    return IconButton(
      icon: Icon(Symbols.category),
      onPressed: () {
        ModalHelper.showDropDownModal(
          context: context,
          data: UiHelper.makeSelectedItems<Category, Category>(
            data: state.value.data!,
            transformation: (e) => SelectedListItem<Category>(data: e),
          ),
          onTap: (selectedItems) {
            final result = <Category>[];
            for (final item in selectedItems) {
              result.add(item.data);
            }
            _onTap(context, result[0].slug!);
          },
        );
      },
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
    return BlocConsumer<CategoryBloc, CategoryState>(
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
