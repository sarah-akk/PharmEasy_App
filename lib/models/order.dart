import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart.dart';

  class OrderItem {
    final int id;
    final double  amount;
    final List<CartItem> products;
    final String dateTime;
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

    Orders(this.authtoken,this.userid,this.oorders)
    {    notifyListeners();
    }

    List<OrderItem> get orders {
      return [...oorders];
    }

    double calculateTotalAmount(List<CartItem> products) {
      return products.fold(0.0, (sum, product) => sum + (product.quantity * product.price));
    }

    ////////////////////////////////////////////////////////////////////////////////////////


    Future<void> fetchOrders() async {
      var url = Uri.parse('http://10.0.2.2:8000/api/viewOrder');

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
      );

      print(response.body);
      final List<OrderItem> loadedOrders = [];
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

      if (extractedData['status'] == 200) {
        final orderList = extractedData['data']['order'] as List<dynamic>;

        orderList.forEach((orderData) {
          final List<CartItem> orderProducts = (orderData['medicines'] as List<dynamic>)
              .map((medicine) => CartItem(
            id: DateTime.now().toString(),
            title: medicine['commercial_name'],
            quantity: medicine['pivot']['request_quantity'].toDouble(),
            price: medicine['price'].toDouble(),
          ))
              .toList();

          loadedOrders.add(OrderItem(
            id: orderData['id'],
            amount: calculateTotalAmount(orderProducts),
            products: orderProducts,
            dateTime: orderData['created_at'],
            status: orderData['status'],
            paymentStatus: orderData['paid_status'] == 1,
          ));
        });

      oorders = loadedOrders.reversed.toList();
      print(oorders);
      notifyListeners();
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/makeOrder');

    print(authtoken);

    List<Map<String, dynamic>> data = cartProducts.map((cp) {
      return {
        'name': cp.title,
        'quantities': cp.quantity,
        // Add other fields if needed
      };
    }).toList();

    // Create the request body
    Map<String, dynamic> requestBody = {
      'data': data,
      // Add other fields if needed
    };
    print(requestBody);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authtoken',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');

      print(response.body);
    }

    notifyListeners();
  }
}
