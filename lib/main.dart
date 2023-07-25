import 'package:cloud_notes/core/model/accounts_category_model.dart';
import 'package:cloud_notes/core/model/accounts_enum.dart';
import 'package:cloud_notes/core/model/accounts_model.dart';
import 'package:cloud_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:cloud_notes/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = await getTemporaryDirectory();
  Hive
    ..init(path.path)
    ..registerAdapter(AccountsCategoryModelAdapter())
    ..registerAdapter(AccountsEnumAdapter())
    ..registerAdapter(AccountsAdapter());
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(Init()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScrollConfiguration(
          behavior: ScrollBehaviorModified(),
          child: HomeScreen(),
        ),
      ),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
