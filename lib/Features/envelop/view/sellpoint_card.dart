import 'package:flutter/material.dart';
import 'package:promoter/Features/envelop/data/sp_model.dart';
import 'package:promoter/Features/envelop/view/sell_point_envelopes_page.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/styles.dart';

class SpCard extends StatelessWidget {
  final String namesp;
  final String schoolName;
  final int id;

  const SpCard(
      {required this.namesp, required this.schoolName, required this.id});
  void _navigateToEnvelopesPage(BuildContext context, int id, String name) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SellPointEnvelopesPage(id: id, name: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToEnvelopesPage(context, id, namesp);
      }, // Pass the selected sell point},
      child: Card(
        margin: EdgeInsets.all(deafultpadding),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(deafultpadding),
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/sp.jpg'),
            backgroundColor: Colors.grey[300],
            radius: 30,
            // child: Image.asset(
            //   'assets/images/sp.jpg',
            // ),
          ),
          title: Text(namesp, style: Styles.textStyle16),
          subtitle: Text(schoolName, style: Styles.textStyle16),
          trailing: Icon(Icons.arrow_circle_right),
        ),
      ),
    );
  }
}
