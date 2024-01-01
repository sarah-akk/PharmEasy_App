import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {

    final username = Provider.of<Auth>(context).UserId;

    return Drawer(
      backgroundColor: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: <Widget>[
                Text('FarmEasy',textAlign:TextAlign.start,style: TextStyle(
                  fontSize: 25,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.black54,),
                ),
                Text('FarmEasy', textAlign:TextAlign.start, style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          ///////////////////////////////////////////////////////////////
          UserAccountsDrawerHeader(
            accountName: Text(
              username!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: null, // You can provide the user's email here if needed
            currentAccountPicture: CircleAvatar(
              // You can customize the profile picture here
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.deepPurple,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
          ),
          //////////////////////////////////////////////////////////////////////////////
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.medical_information,color: Colors.white,),
            title: Text('Medicines',style: TextStyle(color: Colors.white,fontSize: 20)),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/MobileOverviewScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite,color: Colors.white,),
            title: Text('favorites', style: TextStyle(color: Colors.white,fontSize: 20)),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/favorites');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.white,),
            title: Text('Order', style: TextStyle(color: Colors.white,fontSize: 20)),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.white,),
            title: Text('LogOut', style: TextStyle(color: Colors.white,fontSize: 20)),

            onTap: () {
              Provider.of<Auth>(context, listen: false).logoutUser();
              Navigator.of(context).pushReplacementNamed('/StartPage');

              // Show Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You have been logged out.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}