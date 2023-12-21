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


  Future<void> fetchAndSetMedicines(String searchQuery) async {


    int categoryID =0;
    if(searchQuery=='Neurological medications')
      categoryID=1;
    else if(searchQuery=='Heart medications')
      categoryID=2;
    else if(searchQuery=='Anti-inflammatories')
      categoryID=3;
    else if(searchQuery=='Food supplements')
      categoryID=4;
    else
      categoryID=5;


    var url = Uri.parse('http://10.0.2.2:8000/api/medicines_category_Id/$categoryID');
    try {
      final response = await http.get(url,headers: {'Content-Type': 'application/json'},);
      Map<String, dynamic> jsonDataMap = json.decode(response.body);
      List<dynamic> data = jsonDataMap['data'];

      List<Medicine> medicinesData = data.map((medData) {
        return Medicine(
          id: medData['id'],
          scientificName: medData['scientific_name'],
          commercialName: medData['commercial_name'],
          category:(medData['category_id']),
          manufacturer: medData['manufacture_company'],
          quantityAvailable: medData['available_quantity'].toDouble(),
          expiryDate: medData['expiration_date'],
          price: medData['price'].toDouble(),
          imageUrl: medData['photo'],
          isfavorate: medData['favorite'] == 1,
        );
      }).toList();

      print(medicinesData.length);
      medicines = medicinesData;
      notifyListeners();

    } catch (error) {
      throw (error);
    }
  }
}
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

