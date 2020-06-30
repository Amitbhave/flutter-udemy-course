import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/providers/Orders.dart' as oi;

class OrderItem extends StatelessWidget {
  final oi.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

}