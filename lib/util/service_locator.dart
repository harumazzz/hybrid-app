import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hybrid_app/api/product_api.dart';
import 'package:hybrid_app/repository/product_repository.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.asNewInstance();

  ServiceLocator._();

  static void registerSingleton<T extends Object>({
    required T instance,
  }) {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerSingleton(instance);
    }
  }

  static void register() {
    registerSingleton<Dio>(
      instance: Dio(
        BaseOptions(
          // maybe should take from dotenv
          baseUrl: 'https://dummyjson.com',
        ),
      ),
    );
    registerSingleton<ProductRepository>(
      instance: ProductRepository(ProductApi()),
    );
  }

  static T get<T extends Object>() {
    assert(_getIt.isRegistered<T>());
    return _getIt.get<T>();
  }
}
