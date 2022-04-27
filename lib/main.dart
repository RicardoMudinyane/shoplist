import 'package:flutter/material.dart';
import 'package:shoplist/screens/home/homeWidgets.dart';
import 'package:shoplist/screens/list/list_home.dart';
import 'package:shoplist/screens/list/products.dart';
import 'package:shoplist/tempFile.dart';
import 'const.dart';
import 'data/routes.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      /*
      onGenerateRoute: (pages) {
        late Widget page;
        if (pages.name == routeList) {
          page = const Home();
        }
        else if (pages.name == routeItems) {
          page = const Products(pages.arguments);
        }
        else {
          throw Exception('Unknown route: ${pages.name}');
        }
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: pages,
        );
      }, */

    );
  }
}
