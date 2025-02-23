import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hybrid_app/widget/category/category_filter.dart';
import 'package:hybrid_app/widget/product_item/product_item_widget.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hybrid_app/main.dart' as app;

void main() {
  // setup integration test : https://docs.flutter.dev/release/breaking-changes/flutter-driver-migration
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Should load product lists', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final firstProduct = find.byType(ProductItemWidget).first;
      await tester.pumpAndSettle();
      expect(firstProduct, findsOneWidget);
    });

    testWidgets('Should load product detail', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final firstProduct = find.byType(ProductItemWidget).first;
      await tester.tap(firstProduct);
      await tester.pumpAndSettle();
      final titleWidget = find.byKey(const Key('title'));
      final categoryWidget = find.byKey(const Key('category'));
      await tester.pumpAndSettle();
      expect(titleWidget, findsOneWidget);
      expect(categoryWidget, findsOneWidget);
    });

    testWidgets('Should load category', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final categoryFilter = find.byType(CategoryFilter).first;
      await tester.tap(categoryFilter);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final selectedItem = find.text('Beauty');
      await tester.pumpAndSettle();
      expect(selectedItem, findsOneWidget);
    });

    testWidgets('Should search for product', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final searchButton = find.byKey(const Key('search_button'));
      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      final searchField = find.byKey(const Key('search_widget'));
      expect(searchField, findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(searchField, 'h');
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final firstProduct = find.byType(ProductItemWidget).first;
      expect(firstProduct, findsOneWidget);
    });

    testWidgets('Should filter for product by category', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final categoryFilter = find.byType(CategoryFilter).first;
      await tester.tap(categoryFilter);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final selectedItem = find.text('Beauty');
      await tester.pumpAndSettle();
      expect(selectedItem, findsOneWidget);
      await tester.tap(selectedItem);
      await tester.pumpAndSettle();
      final firstProduct = find.byType(ProductItemWidget).first;
      expect(firstProduct, findsOneWidget);
    });
  });
}
