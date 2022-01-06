import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  // Constructor
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // User Input values
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  /// Function that handles submission of the form
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    // Closes the top most screen (the modal)
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.purple,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (value) => {titleInput = value},
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              onSubmitted: (_) => submitData(),
              // onChanged: (value) => {amountInput = value},
            ),
            TextButton(
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
