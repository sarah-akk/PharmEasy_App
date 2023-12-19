import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicines.dart';
import 'medicine_item.dart';

class MedicineGride extends StatefulWidget {
  @override
  _MedicineGrideState createState() => _MedicineGrideState();
}

class _MedicineGrideState extends State<MedicineGride> {
  @override
  void initState() {
    super.initState();
    refrechProducts(context);
  }

  Future<void> refrechProducts(BuildContext context) async {
    await Provider.of<MedicinesList>(context, listen: false).fetchAndSetMedicines(true);
  }

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<MedicinesList>(context);

    return RefreshIndicator(
      onRefresh: () => refrechProducts(context),
      child: productsData.items.isEmpty
          ? Center(child: CircularProgressIndicator())
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
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
