import 'package:flutter/material.dart';
import 'package:shopapp/screens/order_details.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Guest!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrderDetails.routeName);
          },
          )
        ],
      ),
    );
  }

}