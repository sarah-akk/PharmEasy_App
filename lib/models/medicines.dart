import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'medicine.dart';
import 'package:provider/provider.dart';

class MedicinesList with ChangeNotifier {
  int id = 0;
  List<Medicine> medicines = [];
  List<Medicine> _favoriteMedicines = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Medicine> get favoriteMedicines {
    return [..._favoriteMedicines];
  }


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

    Medicine findFavById(int id) {
      return favoriteMedicines.firstWhere((prod) => prod.id == id);
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<void> fetchAndSetMedicines(String searchQuery) async {
    _isLoading = true;
    notifyListeners();

    int categoryID = 0;
    if (searchQuery == 'Neurological medications')
      categoryID = 1;
    else if (searchQuery == 'Heart medications')
      categoryID = 2;
    else if (searchQuery == 'Anti-inflammatories')
      categoryID = 3;
    else if (searchQuery == 'Food supplements')
      categoryID = 4;
    else
      categoryID = 5;


    var url = Uri.parse(
        'http://10.0.2.2:8000/api/medicines_category_Id/$categoryID');
    try {
      final response = await http.get(
        url,  headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      );
      Map<String, dynamic> jsonDataMap = json.decode(response.body);
      List<dynamic> data = jsonDataMap['data'];

      List<Medicine> medicinesData = data.map((medData) {
        return Medicine(
          id: medData['id'],
          scientificName: medData['scientific_name'],
          commercialName: medData['commercial_name'],
          category: (medData['category_id']),
          manufacturer: medData['manufacture_company'],
          quantityAvailable: medData['available_quantity'].toDouble(),
          expiryDate: medData['expiration_date'],
          price: medData['price'].toDouble(),
          imageUrl: medData['photo'],
          isfavorate: false,
        );
      }).toList();

      print(medicinesData.length);
      medicines = medicinesData;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> fetchFavoriteMedicines() async {
    _isLoading = true;
    notifyListeners();

    var url = Uri.parse('http://10.0.2.2:8000/api/list');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['data'];

      List<Medicine> medicinesData = data.map((item) {
        // Access 'medicine' field for each favorite item
        Map<String, dynamic> medicineData = item['medicine'];

        return Medicine(
          id: medicineData['id'],
          scientificName: medicineData['scientific_name'],
          commercialName: medicineData['commercial_name'],
          category: medicineData['category_id'],
          manufacturer: medicineData['manufacture_company'],
          quantityAvailable: medicineData['available_quantity'].toDouble(),
          expiryDate: medicineData['expiration_date'],
          price: medicineData['price'].toDouble(),
          imageUrl: medicineData['photo'],
          isfavorate: false,
        );
      }).toList();

      _favoriteMedicines = medicinesData;
      print(_favoriteMedicines);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<void> getSearch(String searchQuery) async {

    print(searchQuery);
    var url = Uri.parse(
        'http://10.0.2.2:8000/api/search');
    try {
      final response = await http.post(
          url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
          body: json.encode(
              {
                'name': searchQuery,
              }
          )
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonDataMap = json.decode(response.body);
        if (jsonDataMap['data'] != null &&
            jsonDataMap['data'] is Map<String, dynamic>) {
          Map<String, dynamic> data = jsonDataMap['data'];

          Medicine medicine = Medicine(
            id: data['id'],
            scientificName: data['scientific_name'],
            commercialName: data['commercial_name'],
            category: data['category_id'],
            manufacturer: data['manufacture_company'],
            quantityAvailable: data['available_quantity'].toDouble(),
            expiryDate: data['expiration_date'],
            price: data['price'].toDouble(),
            imageUrl: data['photo'],
            isfavorate: false,
          );

          medicines.clear();
          medicines.add(medicine);
          _isLoading = false;
          notifyListeners();
        }
      }
    }
    catch (error) {
      throw (error);
    }
  }
////////////////////////////////////////////////////////////////////////////////////////


  Future<bool> favoriteMedicine(int medicineId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/favorite/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        print('Medicine favorited successfully');
        return true;
      } else {
        print('Failed to favorite medicine. Status code: ${response.statusCode}');
        return true;
      }
    } catch (error) {
      print('Error favoriting medicine: $error');
    }
    return false;
  }

  Future<bool> unfavoriteMedicine(int medicineId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/unfavorite/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        print('Medicine unfavorited successfully');
        return false;
      } else {
        print('Failed to unfavorite medicine. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error unfavoriting medicine: $error');
    }
    return true;
  }


  Future<bool> isMedicineFavorite(int medicineId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/checkfavorite/$medicineId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['is_favorite'];
      } else {
        print('Failed to check favorite status. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error checking favorite status: $error');
      return false;
    }
  }


}
