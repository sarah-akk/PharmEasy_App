import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/Fav_Medicine_Details_Card.dart';
import '../models/medicine.dart';
import '../Screens/item_details.dart';

class MedicineFavItem extends StatelessWidget{

  final Medicine med;
  MedicineFavItem(this.med);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
                FavMedicineDetailsCard.routeName,
                arguments: med.id);
          },
          child: Image.network(
            med.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.deepPurpleAccent.shade100,
          title: Text(
            med.commercialName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ),
    );
  }

}