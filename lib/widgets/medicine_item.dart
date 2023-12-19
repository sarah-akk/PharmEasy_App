import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
import 'item_details.dart';

class MedicineItem extends StatelessWidget{

  final Medicine med;
  MedicineItem(this.med);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final medicine = Provider.of<Medicine>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
        child: GestureDetector(
        onTap: () {
      Navigator.of(context).pushNamed(
          MedicineDetailsCard.routeName,
          arguments: med.id);
    },
    child: Image.network(
      med.imageUrl,
    fit: BoxFit.cover,
    ),
    ),
    footer: GridTileBar(
    backgroundColor: Colors.lightBlueAccent,
    title: Text(
      med.commercialName,
    textAlign: TextAlign.center,
    ),
    ),
    ),
    );
  }
  
}