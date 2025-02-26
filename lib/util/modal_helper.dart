import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_app/extension/localization.dart';

class ModalHelper {
  static void showDropDownModal<T>({
    required BuildContext context,
    required List<SelectedListItem<T>> data,
    void Function(List<SelectedListItem<T>>)? onTap,
  }) {
    DropDownState<T>(
      dropDown: DropDown<T>(
        data: data,
        onSelected: onTap,
        searchHintText: context.localization.search,
      ),
    ).showModal(context);
  }
}
