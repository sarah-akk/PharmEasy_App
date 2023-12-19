import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
          Divider(),
          ListTile(
            leading: Icon(Icons.medical_information,color: Colors.white,),
            title: Text('Medicines',style: TextStyle(color: Colors.white,fontSize: 20)),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/MobileOverviewScreen');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.white,),
            title: Text('Order', style: TextStyle(color: Colors.white,fontSize: 20)),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.white,),
            title: Text('LogOut', style: TextStyle(color: Colors.white,fontSize: 20)),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/StartPage');
            },
          ),
        ],
      ),
    );
  }
}