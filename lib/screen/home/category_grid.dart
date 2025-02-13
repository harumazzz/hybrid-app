import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/category_bloc/category_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/model/category.dart';
import 'package:hybrid_app/util/dialog_helper.dart';
import 'package:hybrid_app/widget/loading/loading_widget.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  Widget _buildCategoriesBox({
    required BuildContext context,
    required CategoryLoaded state,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        spacing: 4.0,
        alignment: WrapAlignment.start,
        children: [...state.value.data!.map((e) => _buildCategory(context: context, category: e))],
      ),
    );
  }

  void _onTap(
    BuildContext context,
    String categoryId,
  ) {
    context.read<ProductBloc>().add(const ProductClearEvent());
    context.read<ProductBloc>().add(ProductFilterEvent(category: categoryId));
  }

  Widget _buildCategory({
    required BuildContext context,
    required Category category,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: InkWell(
        onTap: () => _onTap(context, category.slug!),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 4.0,
          ),
          child: Text(
            category.name!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ),
      ),
    );
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
