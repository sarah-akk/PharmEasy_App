import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String status;
  final bool paymentStatus;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.status,
    required this.paymentStatus,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> oorders = [];
  final String? authtoken;
  final String? userid;


  Orders(this.authtoken,this.userid,this.oorders);

  List<OrderItem> get orders {
    return [...oorders];
  }


  ////////////////////////////////////////////////////////////////////////////////////////


  Future<void> fechAndSetOrders()async {
    var url = Uri.parse(
        'https://artful-striker-383809-default-rtdb.firebaseio.com/orders/$userid.json?auth=$authtoken');
    final response = await http.get(url);
    final List<OrderItem> LoadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData != null) {
      extractedData.forEach((orderID, orderData) {
        LoadedOrders.add(OrderItem(
          id: orderID,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) =>
              CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'])).toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
          status: 'sended',
          paymentStatus: false,

        ));
      });
      oorders = LoadedOrders.reversed.toList();
      notifyListeners();
    }

    else {
      return;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse(
        'https://artful-striker-383809-default-rtdb.firebaseio.com/orders/$userid.json?auth=$authtoken');
    final response = await http.post(url,body: json.encode({
      'amount':total,
      'dateTime':DateTime.now().toIso8601String(),
      'products': cartProducts.map((cp) => {
        'id':cp.id,
        'title':cp.title,
        'quantity':cp.quantity,
        'price':cp.price,

      }).toList(),

    }),);
    oorders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
        paymentStatus: false,
        status: '',
      ),
    );
    notifyListeners();
  }
}
