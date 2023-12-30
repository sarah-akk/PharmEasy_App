
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartItem extends StatelessWidget{
  final String id ;
  final String productId;
  final double price;
  final double quantity;
  final String title;

  const CartItem({Key? key,  required this.id,required this.productId, required this.price, required this.quantity, required this.title}) : super(key: key);

  //////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete,
          color: Colors.white,
          size: 40,),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      ),
      direction: DismissDirection.endToStart,

      confirmDismiss: (direction){
        return showDialog(context: context,
            builder: (ctx)=>AlertDialog(
              title: Text('are you sure ?'),
              content: Text('Do you want to remove the item from the card?'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(ctx).pop(false);
                    },
                    child: Text('No')),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(ctx).pop(true);
                    },
                    child: Text('yes'))

              ],
            )
        );
      },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },

      child: Card(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),

          child: Padding(
            padding: EdgeInsets.all(8),
            child:ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent ,
                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox (child : Text('\$$price',style: TextStyle(color: Colors.white),)),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total :  \$${(price * quantity)}'),
              trailing: Text('$quantity x'),
            ) ,
          )

      ),
    );
  }
}