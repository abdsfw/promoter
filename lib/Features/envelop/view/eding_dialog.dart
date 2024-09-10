import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/generated/l10n.dart';

// import '../../../generated/l10n.dart';

class EditCashDialog extends StatefulWidget {
  final int envelopeId;
  final double currentCash;
  final int? spexpenses;
  final Function(double) onUpdate;

  EditCashDialog(
      {required this.envelopeId,
      required this.currentCash,
      required this.onUpdate,
      required this.spexpenses});

  @override
  _EditCashDialogState createState() => _EditCashDialogState();
}

class _EditCashDialogState extends State<EditCashDialog> {
  final TextEditingController cashController = TextEditingController();
  final TextEditingController spexpensesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    cashController.text = widget.currentCash.toString();
    spexpensesController.text = widget.spexpenses.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(
          S.of(context).editCash,
          style: Styles.titleDialog,
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: cashController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: S.of(context).newCash,
                    labelStyle: Styles.textStyle12),
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).pleaseEnterAValue;
                  }
                  final newCash = double.tryParse(value);
                  if (newCash == null || newCash < 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null; // Return null to indicate no error
                },
              ),
             
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              S.of(context).cancel,
              style: Styles.textStyle14,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final newCash = double.tryParse(cashController.text) ?? 0.0;
               
                try {
                  // Call the API to update the cash
                  await widget.onUpdate(newCash);

                  // Show a Snackbar to indicate a successful update
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).cashUpdatedSuccessfully,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.white, // Background color
                      elevation: 6, // Elevation (shadow) of the SnackBar
                      behavior:
                          SnackBarBehavior.floating, // Floating SnackBar style
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                  );

                  // Close the dialog
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error updating cash: $e');
                  // Handle error here
                }
              }
            },
            child: Text(
              S.of(context).update,
              style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
