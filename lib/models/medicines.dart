import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'medicine.dart';
import 'package:provider/provider.dart';

class MedicinesList with ChangeNotifier {
  int id = 0;
  List<Medicine> medicines = [];

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  final String? authToken;
  final String? userId;

  MedicinesList(this.authToken, this.userId, this.medicines) {
    notifyListeners();
  }

  notifyListeners();

  List<Medicine> get items {
    return [...medicines];
  }

  Medicine findById(int id) {
    return items.firstWhere((prod) => prod.id == id);
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<void> fetchAndSetMedicines([bool filterByUser = false]) async {
    //final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://artful-striker-383809-default-rtdb.firebaseio.com/medicines.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      print(response.body);
      if (extractedData == null) {
        return;
      }

      final List<Medicine> loadedProducts = [];
      extractedData.forEach((medId, medData) {
        loadedProducts.add(Medicine(
          id: id++,
          scientificName: medData['scientific_name'],
          commercialName: medData['commercial_name'],
          category: medData['category'],
          manufacturer: medData['manufacture_company'],
          quantityAvailable: medData['available_quantity'],
          expiryDate: DateTime.parse(medData['expiration_date']),
          price: medData['price'],
          imageUrl: medData['photo'],
          isfavorate: medData['favorite'],
        ));
      });

      medicines = loadedProducts;
      print(loadedProducts.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

