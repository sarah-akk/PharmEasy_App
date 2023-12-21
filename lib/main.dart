
import 'package:flutter/material.dart';
import 'package:pharmacist_app/start_page.dart';
import 'package:provider/provider.dart';

import 'Screens/categories_screen.dart';
import 'Screens/login.dart';
import 'models/Auth.dart';
import 'models/medicines.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Auth()),

          ChangeNotifierProxyProvider<Auth,MedicinesList>(
            create: (_) => MedicinesList('','',[]), // Create your Products instance here.
            update: (ctx, auth, previousProducts) => MedicinesList(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.medicines,
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.blueAccent,
            hintColor: Colors.greenAccent,
            // Add more theme properties
          ),
          debugShowCheckedModeBanner: false,
          home:StartPage(),

          routes: {

            StartPage.routeName:(ctx)=>StartPage(),
            MobileAuthScreen.routeName:(ctx)=>MobileAuthScreen(),
            MobileOverviewScreen.routeName:(ctx)=>MobileOverviewScreen(),
          },



        )
    );

  }
}
