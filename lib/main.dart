
import 'package:flutter/material.dart';
import 'package:pharmacist_app/start_page.dart';
import 'package:pharmacist_app/Screens/item_details.dart';
import 'package:provider/provider.dart';

import 'Screens/Fav_Medicine_Details_Card.dart';
import 'Screens/cart_screen.dart';
import 'Screens/categories_screen.dart';
import 'Screens/favorites_screen.dart';
import 'Screens/login.dart';
import 'Screens/orders_screen.dart';
import 'models/Auth.dart';
import 'models/cart.dart';
import 'models/medicines.dart';
import 'models/order.dart';

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
          //////////////////////////////////////////////////////////////////////////
          ChangeNotifierProxyProvider<Auth,MedicinesList>(
            create: (_) => MedicinesList('','',[]), // Create your Products instance here.
            update: (ctx, auth, previousProducts) => MedicinesList(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.medicines,
            ),
          ),
          /////////////////////////////////////////////////////////////////////////
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          /////////////////////////////////////////////////////////////////////////
          ChangeNotifierProxyProvider<Auth,Orders>(
            create: (_) => Orders('','',[]), // Create your Products instance here.
            update: (ctx, auth, previousOrder) => Orders(
              auth.token,
              auth.userId,
              previousOrder == null ? [] : previousOrder.oorders,
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
            MedicineDetailsCard.routeName:(ctx)=>MedicineDetailsCard(),
            FavMedicineDetailsCard.routeName:(ctx)=>FavMedicineDetailsCard(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            FavoritesScreen.routeName:(ctx)=>FavoritesScreen(),
          },

        )
    );

  }
}
