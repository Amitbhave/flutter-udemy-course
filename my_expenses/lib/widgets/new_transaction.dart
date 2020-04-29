import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget{
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Title'
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Amount'
              ),
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: () {
                addTransactionHandler(
                    titleController.text,
                    double.parse(amountController.text)
                );
              },
            )
          ],
        ),
      ),
    );
  }
  
}