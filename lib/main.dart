import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/features/shops/presentation/bloc/shops_cubit/shop_cubit.dart';
import 'package:shop/features/shops/presentation/pages/shops_page.dart';

import 'injection_container.dart' as di;
import 'injection_container.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shops",
          theme: ThemeData(
            colorSchemeSeed: Colors.green,
            useMaterial3: true,
          ),
          home: BlocProvider(
            create: (_) => sl<ShopCubit>()..fetchShops(),
            child: const ShopsPage(),
          ),
        );
      },
    );
  }
}