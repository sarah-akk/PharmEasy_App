import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
import '../models/medicines.dart';
import '../widgets/Drawer.dart';
import '../widgets/favorate_item.dart';
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
        iconTheme: IconThemeData(
          color: Colors.deepPurple, // Change the color to your desired color
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0)
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Container(
      height: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset("assets/images/favorates.jpg")),
          RefreshIndicator(
            onRefresh: () => refreshProducts(context),
            child: SingleChildScrollView(
              child: Container(
                height: 600,
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
                      child: MedicineFavItem(
                        productsData.favoriteMedicines[i],
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
