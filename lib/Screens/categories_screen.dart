import 'package:flutter/material.dart';
import '../widgets/category_item.dart'; // Assuming you have a separate file for this widget
import '../widgets/Drawer.dart';
import 'medicines_screen.dart';

class MobileOverviewScreen extends StatefulWidget {
  const MobileOverviewScreen({Key? key}) : super(key: key);

  static const routeName = '/MobileOverviewScreen';

  @override
  State<MobileOverviewScreen> createState() => _HomePageState();
}

class _HomePageState extends State<MobileOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple, // Change the color to your desired color
        ),
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: true,
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'PharmEasy',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),

      body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          /////////////////////////////////////////////////////////
                          SizedBox(height: 20),
                          ////////////////////////////////////////////////////////
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(
                              "assets/images/medicines-online.jpg",
                              fit: BoxFit.cover,
                              height: 250,
                            ),
                          ),
                          /////////////////////////////////////////////////////////
                          SizedBox(height: 20),
                          /////////////////////////////////////////////////////////
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Categories :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          ///////////////////////////////////////////////////////////
                          SizedBox(height: 20),
                          //////////////////////////////////////////////////////////
                          Container(height: 2000,child: CategoryListView()),
                        ],
                      ),
                    ]),
              ),

            ),
          ]),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////
