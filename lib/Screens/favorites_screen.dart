import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
import '../models/medicines.dart';
import '../widgets/Drawer.dart';
import '../widgets/medicine_item.dart';

// FavoritesScreen
class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    refreshProducts(context);
  }

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<MedicinesList>(context, listen: false)
        .fetchFavoriteMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MedicinesList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Container(
          padding: EdgeInsets.all(10),
          child: productsData.isLoading
              ? Center(child: CircularProgressIndicator())
              : (productsData.favoriteMedicines.isEmpty
              ? Center(
            child: Image.asset(
              'assets/images/no-product-available-hd-png-download.png',
              fit: BoxFit.cover,
            ),
          )
              : Consumer<MedicinesList>(
            builder: (ctx, productsData, _) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: productsData.favoriteMedicines.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: productsData.favoriteMedicines[i],
                child: MedicineItem(
                  productsData.favoriteMedicines[i],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
