import 'package:flutter/material.dart';
import '../Screens/medicines_screen.dart';

class Category {
  final String title;
  final Color color;
  final String imageAsset;

  Category({required this.title, required this.color, required this.imageAsset});
}

class CategoryListView extends StatelessWidget {
  final List<Category> categories = [
    Category(
      title: 'Neurological medications',
      color: Colors.blue,
      imageAsset: 'assets/images/Neurological medications.jpg',
    ),
    Category(
      title: 'Heart medications',
      color: Colors.red,
      imageAsset: 'assets/images/Heart medications.jpg',
    ),
    Category(
      title: 'Anti-inflammatories',
      color: Colors.green,
      imageAsset: 'assets/images/Anti-inflammatories.jpg',
    ),
    Category(
      title: 'Food supplements',
      color: Colors.orange,
      imageAsset: 'assets/images/Food supplements.jpg',
    ),
    Category(
      title: 'Painkillers',
      color: Colors.purple,
      imageAsset: 'assets/images/Painkillers.jpg',
    ),
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length * 2 - 1,
        // Adjust item count to include dividers
        itemBuilder: (context, index) {
          if (index.isOdd) {
            // If index is odd, return Divider
            return Divider();
          }

          // Calculate the actual index for the category
          final categoryIndex = index ~/ 2;
          return ListTile(
              title: Text(
                categories[categoryIndex].title,
                style: TextStyle(fontSize: 20),
              ),
              leading: CircleAvatar(
                backgroundColor: categories[categoryIndex].color,
                backgroundImage: AssetImage(
                    categories[categoryIndex].imageAsset),
              ),
              onTap: () {
                // Navigate to the MedicinesScreen with the selected category
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MedicinesScreen(
                          category: categories[categoryIndex].title,
                        ),
                  ),

                );
               // print(categories[categoryIndex].title);
              }
          );
        }
    );
  }
}