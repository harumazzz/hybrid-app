import 'package:drop_down_list/model/selected_list_item.dart';

class UiHelper {
  static List<SelectedListItem<U>> makeSelectedItems<T, U>({
    required List<T> data,
    required SelectedListItem<U> Function(T data) transformation,
  }) {
    final result = <SelectedListItem<U>>[];
    for (final e in data) {
      result.add(transformation(e));
    }
    return result;
  }
}
