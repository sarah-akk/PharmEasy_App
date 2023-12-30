import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart' show Orders;
import '../widgets/drawer.dart';
import '../widgets/order_item.dart';
import '../widgets/drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var isLoading = false;

  void initState(){
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading=true;
      });
      await Provider.of<Orders>(context,listen: false).fetchOrders();
      setState(() {
        isLoading=false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, // Change the color to your desired color
        ),
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: true,
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'orders',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: isLoading?Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
