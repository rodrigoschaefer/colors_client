import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:colors_client/core/util/Constants.dart';
import 'package:colors_client/features/color/data/repositories/color_repository_local_impl.dart';

import 'core/presentation/home_page.dart';

import 'features/account/data/models/account.dart';
import 'features/color/data/datasources/color_local_rpc_datasource.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initApp();
  runApp(const CApp());
}

initApp() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  await Hive.openBox<Account>(Constants.accountBox);
  initializeDateFormatting();
}

class CApp extends StatelessWidget {
  const CApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
    );
    return MaterialApp(
      title: 'Colors NFT',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            secondary: Colors.white,
            primary: Colors.blue,
            background: Colors.green),
        cardTheme: const CardTheme(color: Colors.lightGreen, elevation: 5),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.green),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            iconTheme: IconThemeData(color: Colors.white)),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(
        colorRepository: ColorRepositoryLocalImpl(ColorLocalRpcDatasource()),
      ),
    );
  }
}
