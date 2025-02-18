import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/cubit/category_cubit/category_cubit.dart';
import 'package:hybrid_app/screen/root_screen.dart';
import 'package:hybrid_app/util/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc()..add(const ProductLoadEvent()),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) {
            final cubit = CategoryCubit();
            cubit.loadCategory();
            return cubit;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Hybrid App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RootScreen(),
      ),
    );
  }
}
