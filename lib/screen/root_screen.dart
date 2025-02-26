import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/cubit/language_cubit/language_cubit.dart';
import 'package:hybrid_app/cubit/product_cubit/product_cubit.dart';
import 'package:hybrid_app/extension/localization.dart';
import 'package:hybrid_app/screen/home/home_screen.dart';
import 'package:hybrid_app/screen/search/search_page.dart';
import 'package:hybrid_app/util/dialog_helper.dart';
import 'package:hybrid_app/util/localization_helper.dart';
import 'package:hybrid_app/widget/category/category_filter.dart';
import 'package:material_symbols_icons/symbols.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  void _onSearch(BuildContext context) {
    context.read<ProductCubit>().clearProducts();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SearchPage(),
      ),
    );
  }

  void _onSetting(BuildContext context) {
    void onChange(String? e) {
      if (e == null) return;
      context.read<LanguageCubit>().changeLangugage(e);
    }

    DialogHelper.showStatefulDialog(
      context: context,
      builder: (context, setState) {
        var selectedValue = context.read<LanguageCubit>().state.value;
        return DialogHelper.buildDialog(
          context: context,
          title: Text(context.localization.change_language),
          content: DropdownButton<String>(
            value: selectedValue,
            items: [
              ...['vi', 'en'].map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(LocalizationHelper.getValue(context, e)),
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedValue = value;
                });
                onChange(value);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.title),
        actions: [
          IconButton(
            key: const Key('search_button'),
            onPressed: () => _onSearch(context),
            icon: const Icon(Symbols.search),
          ),
          CategoryFilter(),
          IconButton(
            onPressed: () => _onSetting(context),
            icon: const Icon(Symbols.settings),
          ),
        ],
      ),
      body: HomeScreen(),
    );
  }
}
