import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/medicines.dart';
import '../models/medicine.dart';


class MedicineDetailsCard extends StatefulWidget {
  static const routeName = '/MedicineDetailsCard';

  @override
  State<MedicineDetailsCard> createState() => _MedicineDetailsCardState();
}

class _MedicineDetailsCardState extends State<MedicineDetailsCard>{

  late bool isFavorite = false ;
  int quantity = 1;
  late Medicine loadedMedicine;
  var is_init=true;


  @override
  Future<void> didChangeDependencies() async {
    if (is_init) {
      try {
        final medicineId = ModalRoute
            .of(context)!
            .settings
            .arguments as int;
        loadedMedicine =
            Provider.of<MedicinesList>(context, listen: false).findById(
                medicineId);

        bool result = await Provider.of<MedicinesList>(context, listen: false)
            .isMedicineFavorite(loadedMedicine.id);

        setState(() {
          isFavorite = result;
          print(isFavorite);
        });
      } catch (error) {
        // Handle errors if needed
      }
      is_init = false;

      super.didChangeDependencies();
    }
  }

  @override
  void initState() {
    super.initState();
    print('initState executed');
  }

  @override
  Widget build(BuildContext context) {

    final medicineId = ModalRoute
        .of(context)!
        .settings
        .arguments as int;

    loadedMedicine = Provider.of<MedicinesList>(
      context,
      listen: false,
    ).findById(medicineId);



      return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // Set your desired height
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Medicine Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: contentBox(context, loadedMedicine),

    );
  }

  Widget contentBox(BuildContext context, Medicine loadedMedicine) {
    String category;

    if (loadedMedicine.category == 1)
      category = 'Neurological medication';
    else if (loadedMedicine.category == 2)
      category = 'Heart medications';
    else if (loadedMedicine.category == 3)
      category = 'Anti-inflammatories';
    else if (loadedMedicine.category == 4)
      category = 'Food supplements';
    else
      category = 'Painkillers';

    ////////////////////////////////////////////////////////////////////////////

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Image.network(
            loadedMedicine.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 70),
          Row(
            children: [
              Text(
                '${loadedMedicine.commercialName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                SizedBox(width: 100),
                Text('\$${loadedMedicine.price.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.pink)),
            ],
          ),
          SizedBox(height: 15),
          Text('${loadedMedicine.scientificName}',
              style: TextStyle(fontSize: 19,color: Colors.black54)),
          SizedBox(height: 30),
          Text('Details : ', style: TextStyle(fontSize: 20, fontWeight:  FontWeight.bold,color: Colors.deepPurpleAccent,)),
          SizedBox(height: 10),
          Text('Manufacturer: ${loadedMedicine.manufacturer}',
              style: TextStyle(fontSize: 18,color: Colors.black45)),
          SizedBox(height: 10),
          Text('Quantity Available: ${loadedMedicine.quantityAvailable
              .toString()}', style: TextStyle(fontSize: 18,color: Colors.black45)),
          SizedBox(height: 10),
          Text('Expiry Date: ${loadedMedicine.expiryDate.toString()}',
              style: TextStyle(fontSize: 18,color: Colors.black45),),
          SizedBox(height: 60),

          /////////////////////////////////////////////////////////////////////////

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                   setState(() {
                    isFavorite = !isFavorite;
                  });

                  try {
                    bool result;
                    if (isFavorite) {
                      // Call the API to favorite the medicine
                      result = await Provider.of<MedicinesList>(context, listen: false)
                          .favoriteMedicine(loadedMedicine.id);
                    } else {
                      // Call the API to unfavorite the medicine
                      result = await Provider.of<MedicinesList>(context, listen: false)
                          .unfavoriteMedicine(loadedMedicine.id);
                    }
                      setState(() {
                        isFavorite = result;
                        print(isFavorite);
                      });

                  } catch (error) {

                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  }
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink,
                  size: 36,
                ),
              ),

              IconButton(
                onPressed: () {
                  _showAddToCartDialog(context);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.deepPurpleAccent,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////

  void _showAddToCartDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context)
    {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add to Cart', style: TextStyle(fontSize: 20)),
            contentPadding: EdgeInsets.all(16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Enter quantity:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: quantity.toString(),
                  onChanged: (value) {
                    setState(() {
                      quantity = int.tryParse(value) ?? 1;
                    });
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Create a new CartItem with the specified quantity
                  CartItem newItem = CartItem(
                    id: DateTime.now().toString(),
                    title: loadedMedicine.commercialName,
                    price: loadedMedicine.price,
                    quantity: quantity.toDouble(),
                  );

                  // Add the new item to the cart
                  Provider.of<Cart>(context, listen: false).addItem(newItem);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Add to Cart', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent, // Set the background color
                  // You can also customize other properties like padding, elevation, etc.
                ),
              ),

              /////////////////////////////////////////////////////////////////////////

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent, // Set the background color
                  // You can also customize other properties like padding, elevation, etc.
                ),
              ),
            ],
          );
        },
      );
    }
    );
  }
}