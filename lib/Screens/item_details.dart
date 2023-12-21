import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../models/medicines.dart';
import '../widgets/Drawer.dart';

class MedicineDetailsCard extends StatelessWidget {
  static const routeName = '/MedicineDetailsCard';

  @override
  Widget build(BuildContext context) {
    final medicineId = ModalRoute.of(context)!.settings.arguments as int;
    final loadedMedicine = Provider.of<MedicinesList>(
      context,
      listen: false,
    ).findById(medicineId);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.white,
        ),// Change the color to your desired color
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ('Medicine Details'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: contentBox(context, loadedMedicine),
      drawer: AppDrawer(),
    );
  }

  Widget contentBox(BuildContext context, Medicine loadedMedicine) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            loadedMedicine.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            'Scientific Name: ${loadedMedicine.scientificName}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text('Commercial Name: ${loadedMedicine.commercialName}'),
          SizedBox(height: 8),
          Text('Category: ${loadedMedicine.category}'),
          SizedBox(height: 8),
          Text('Manufacturer: ${loadedMedicine.manufacturer}'),
          SizedBox(height: 8),
          Text('Quantity Available: ${loadedMedicine.quantityAvailable.toString()}'),
          SizedBox(height: 8),
          Text('Expiry Date: ${loadedMedicine.expiryDate.toString()}'),
          SizedBox(height: 8),
          Text('Price: \$${loadedMedicine.price.toString()}'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the screen
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
