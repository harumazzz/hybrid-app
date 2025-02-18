import 'package:drop_down_list/model/selected_list_item.dart';

class UiHelper {
  static List<SelectedListItem<T>> makeSelectedItems<T>({
    required List<T> data,
    required SelectedListItem<T> Function(T data) transformation,
  }) {
    final result = <SelectedListItem<T>>[];
    for (final e in data) {
      result.add(transformation(e));
    }
    return result;
  }

  static List<SelectedListItem<T>> makeDefaultItems<T>({
    required List<T> data,
  }) {
    return makeSelectedItems<T>(
      data: data,
      transformation: (e) => SelectedListItem<T>(data: e),
    );
  }

  static List<T> toItemList<T>(
    List<SelectedListItem<T>> selectedItems,
  ) {
    final result = <T>[];
    for (final item in selectedItems) {
      result.add(item.data);
    }
    return result;
  }
}
