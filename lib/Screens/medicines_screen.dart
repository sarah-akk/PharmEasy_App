import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../widgets/Drawer.dart';
import '../widgets/medicine_gride.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MedicinesScreen extends StatefulWidget {
  final String category;

  MedicinesScreen({required this.category});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, // Change the color to your desired color
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ('${widget.category}'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
          actions: <Widget>[
      Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: ch,
            label: Text(cart.itemCount.toString()),
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),
      ]
      ),
      /////////////////////////////////////////////////////////////////////////////////
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 50.0,
              width: 350.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for medicines ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  // Return an empty list to disable suggestions
                  return [];
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  // Handle the selection of a suggestion
                  setState(() {
                    _searchQuery = suggestion;
                  });
                },
              ),
            ),
          ),
         Expanded(
           child: SingleChildScrollView(
             child: Container(
                 height:1000,
                 child: MedicineGride(widget.category)),
           ),
         ),
        ],
      ),
    );
  }
}
