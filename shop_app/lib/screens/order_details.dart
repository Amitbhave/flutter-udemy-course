import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/Orders.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart' as oi;

class OrderDetails extends StatelessWidget {
  static const String routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, index) => oi.OrderItem(ordersData.orders[index]),
      ),
    );
  }

}