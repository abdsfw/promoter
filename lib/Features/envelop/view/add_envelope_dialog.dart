import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/cash/cache_helper.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/generated/l10n.dart';

String t = CasheHelper.getData(key: 'token');
bool isAddingEnvelope = false;

class AddEnvelopeDialog extends StatefulWidget {
  final int sellPointId;
  final Function(bool) onEnvelopeAdded;

  AddEnvelopeDialog({required this.sellPointId, required this.onEnvelopeAdded});

  @override
  _AddEnvelopeDialogState createState() => _AddEnvelopeDialogState();
}

class _AddEnvelopeDialogState extends State<AddEnvelopeDialog> {
  final TextEditingController cashController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController spexpensesController = TextEditingController();

  String errorText = '';
  DateTime selectedDate = DateTime.now();
  bool isAddingEnvelope = false;
  @override
  void dispose() {
    cashController.dispose();
    dateController.dispose();
    numberController.dispose();
    super.dispose();
  }

  Future<void> addEnvelope() async {
    final double cash = double.tryParse(cashController.text) ?? 0.0;
    final String date = dateController.text;
    final int number = int.tryParse(numberController.text) ?? 0;

    if (cash > 0 && date.isNotEmpty && number > 0) {
      setState(() {
        isAddingEnvelope = true; // Show loading indicator
      });
      try {
        final Uri url =
            Uri.parse('$baseUrl/sell-points/envelop/add/${widget.sellPointId}');
        print(widget.sellPointId);
        final Map<String, dynamic> envelopeData = {
          "data": {
            "cash": cash,
            "date": date,
            "number": number,
          }
        };
        print(t);
        final headers = {
          'Authorization': 'Bearer $t',
          'Content-Type': 'application/json', // Add your token here
        };
        print(json.encode(envelopeData));
        final response = await http.post(
          url,
          headers: headers,
          body: json.encode(envelopeData),
        );

        print(response.statusCode);
        // print(response.body);
        if (response.statusCode == 200) {
          widget.onEnvelopeAdded(true); // Notify parent about success
          Navigator.of(context).pop(); // Close the dialog
        } else {
          print('Failed to add envelope: ${response.reasonPhrase}');
          throw Exception('Failed to add envelope');
        }
      } catch (e) {
        print('Error adding envelope: $e');
        widget.onEnvelopeAdded(false); // Notify parent about failure
        Navigator.of(context).pop(); // Close the dialog
      } finally {
        if (mounted) {
          setState(() {
            isAddingEnvelope = false; // Hide loading indicator
          });
        }
      }
    } else {
      setState(() {
        errorText = S.of(context).allFieldsRequiredAndValid;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(S.of(context).addNewEnvelope, style: Styles.titleDialog),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                  labelText: S.of(context).number,
                  labelStyle: Styles.textStyle12),
            ),
            TextField(
              controller: cashController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                  labelText: S.of(context).cash,
                  labelStyle: Styles.textStyle12),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                        labelText: S.of(context).dateYYYYMMDD,
                        labelStyle: Styles.textStyle12),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            ),
          ],
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
              // Call the API to add the envelope
              await addEnvelope();
            },
            child: isAddingEnvelope
                ? const SpinKitFoldingCube(
                    color: Colors.white,
                    size: 35,
                  ) // Show loading indicator
                : Text(S.of(context).add),
          ),
        ],
      ),
    );
  }
}
