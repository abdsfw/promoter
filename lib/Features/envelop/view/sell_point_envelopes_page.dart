import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:promoter/Features/envelop/data/api_server.dart';
import 'package:promoter/Features/envelop/data/sp_model.dart';
import 'package:promoter/Features/envelop/view/add_envelope_dialog.dart';
import 'package:promoter/Features/envelop/view/eding_dialog.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/generated/l10n.dart';
import 'package:intl/intl.dart';

class SellPointEnvelopesPage extends StatefulWidget {
  final int id;
  final String name;

  SellPointEnvelopesPage({required this.id, required this.name});

  @override
  _SellPointEnvelopesPageState createState() => _SellPointEnvelopesPageState();
}

class _SellPointEnvelopesPageState extends State<SellPointEnvelopesPage> {
  List<Envelope> envelopes = [];
  bool isLoading = true;
  bool isDeleting = false;
  String deleteResultMessage = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    fetchEnvelopesForSellPoint();
  }

  void onEdit(Envelope envelope, double currentCash, int? currentspexpenses) {
    final envelopeApi = Apienvelop();
    showDialog(
      context: context,
      builder: (context) {
        return EditCashDialog(
          spexpenses: currentspexpenses,
          envelopeId: envelope.id,
          currentCash: currentCash,
          onUpdate: (double newCash ) async {
            // Call the API to update the cash
            await envelopeApi.updateEnvelopeCash(
                envelope.id, newCash );

            // Refresh the list of envelopes
            fetchEnvelopesForSellPoint();

            // Close the dialog
          },
        );
      },
    );
  }

  Future<void> fetchEnvelopesForSellPoint() async {
    final envelopeApi = Apienvelop();
    try {
      final List<Envelope> data =
          await envelopeApi.fetchEnvelopesForSellPoint(widget.id);
      setState(() {
        envelopes = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching envelopes: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> deleteEnvelope(int envelopeId) async {
    setState(() {
      isDeleting = true;
      deleteResultMessage = ''; // Clear the previous result message
    });

    final envelopeApi = Apienvelop();
    try {
      await envelopeApi.deleteEnvelope(
        envelopeId,
      );
      // Remove the deleted envelope from the list
      if (mounted) {
        setState(() {
          envelopes.removeWhere((envelope) => envelope.id == envelopeId);
          isDeleting = false;
          deleteResultMessage = S.of(context).envelopeDeletedSuccessfully;
        });
      }
    } catch (e) {
      print('Error deleting envelope: $e');
      if (mounted) {
        setState(() {
          isDeleting = false;
          deleteResultMessage = S.of(context).failedToDeleteEnvelope;
        });
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(deleteResultMessage),
        backgroundColor: isDeleting
            ? Colors.orange
            : Colors
                .green, // Set background color based on the operation status
        elevation: 6, // Elevation (shadow) of the SnackBar
        behavior: SnackBarBehavior.floating, // Floating SnackBar style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(int envelopeId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            S.of(context).confirmDeletion,
            style: Styles.titleDialog,
          ),
          content: Text(
            S.of(context).confirmDeleteEnvelope,
            style: Styles.textStyle16,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(S.of(context).cancel, style: Styles.textStyle14),
            ),
            TextButton(
              onPressed: () async {
                // Close the dialog and delete the envelope
                Navigator.of(context).pop();
                await deleteEnvelope(envelopeId);
              },
              child: Text(
                S.of(context).delete,
                style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${S.of(context).envelopesFor} :${widget.name}'),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitFoldingCube(
              color: Colors.white,
              size: 35,
            ))
          : envelopes.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).noEnvelopesFound,
                    style: Styles.textStyle16,
                  ),
                )
              : FadeInDown(
                  delay: const Duration(milliseconds: 500),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(80)),
                    ),
                    child: ListView.builder(
                      itemCount: envelopes.length,
                      itemBuilder: (context, index) {
                        final envelope = envelopes[index];
                        return EnvelopeListItem(
                          envelope: envelope,
                          onDelete: () {
                            // Implement delete functionality here

                            showDeleteConfirmationDialog(envelope.id);
                          },
                          onEdit: () {
                            // Implement edit functionality here
                            onEdit(
                                envelope, envelope.cash!, envelope.spexpenses);
                          },
                          isDeleting: isDeleting,
                        );
                      },
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: () async {
          // Show the dialog to add a new envelope here
          final result = await showDialog(
            context: context,
            builder: (context) {
              return AddEnvelopeDialog(
                sellPointId: widget.id, // Pass the sellPointId to the dialog
                onEnvelopeAdded: (bool success) {
                  // Handle success or failure
                  if (success) {
                    // Reload the list of envelopes or perform any other actions
                    fetchEnvelopesForSellPoint();
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
                              S.of(context).envelopeAddedSuccessfully,
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.white, // Background color
                        elevation: 6, // Elevation (shadow) of the SnackBar
                        behavior: SnackBarBehavior
                            .floating, // Floating SnackBar style
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              S.of(context).failedToAddEnvelope,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.white, // Background color
                        elevation: 6, // Elevation (shadow) of the SnackBar
                        behavior: SnackBarBehavior
                            .floating, // Floating SnackBar style
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                    );

                    // Handle failure, show an error message, etc.
                  }
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EnvelopeListItem extends StatelessWidget {
  final Envelope envelope;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isDeleting;

  EnvelopeListItem({
    required this.envelope,
    required this.onDelete,
    required this.onEdit,
    required this.isDeleting,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          '${S.of(context).envelopeNumber}: ${envelope.number}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${S.of(context).theCash} : ${envelope.cash!.toStringAsFixed(2)}',
                style: Styles.textStyle18.copyWith(color: Colors.green[500])),
            Text(
              '${S.of(context).date}: ${DateFormat('yyyy-MM-dd', 'en').format(envelope.date!.toLocal())}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                size: 24,
                color: Colors.blue,
              ),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                size: 24,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
