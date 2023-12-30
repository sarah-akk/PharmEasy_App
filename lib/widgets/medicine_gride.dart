import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicines.dart';
import 'medicine_item.dart';

class MedicineGride extends StatefulWidget {

  String searchCategory;
  String searchQuery;
  MedicineGride(this.searchCategory, this.searchQuery);

  @override
  _MedicineGrideState createState() => _MedicineGrideState();
}

class _MedicineGrideState extends State<MedicineGride> {
  @override
  void initState() {
    super.initState();
    refrechProducts(context, widget.searchCategory);
  }

  Future<void> refrechProducts(BuildContext context, String searchCategory) async {
    await Provider.of<MedicinesList>(context, listen: false)
        .fetchAndSetMedicines(searchCategory);
  }

  Future<void> getsearch(BuildContext context, String searchQuery) async {
    await Provider.of<MedicinesList>(context, listen: false)
        .getSearch(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MedicinesList>(context);

    return RefreshIndicator(
      onRefresh: ()   {
      if (widget.searchQuery.isEmpty) {
        return refrechProducts(context,widget.searchCategory);
      } else {
        widget.searchQuery='';
        return getsearch(context,widget.searchQuery);
      }
    },
      child: productsData.isLoading
          ? Center(child: CircularProgressIndicator())
          : (productsData.items.isEmpty
          ? Center(
        child: Image.asset(
          'assets/images/no-product-available-hd-png-download.png', // Replace with your image path
          fit: BoxFit.cover,
        ),
      )
          : Consumer<MedicinesList>(
        builder: (ctx, productsData, _) => GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: productsData.items.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: productsData.items[i],
            child: MedicineItem(
              productsData.items[i],
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      )),
    );
  }
}
