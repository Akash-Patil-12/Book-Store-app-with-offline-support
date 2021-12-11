import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveFromCard extends StatefulWidget {
  //const RemoveFromCard({ Key? key }) : super(key: key);
  final Function removeFromCardCallBack;
  RemoveFromCard({required this.removeFromCardCallBack});
  @override
  _RemoveFromCardState createState() =>
      _RemoveFromCardState(removeFromCardCallBack);
}

class _RemoveFromCardState extends State<RemoveFromCard> {
  final Function removeFromCardCallBack;
  _RemoveFromCardState(this.removeFromCardCallBack);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: const Text(
          'Remove From Card',
          style: TextStyle(fontSize: 9, color: Colors.white),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.brown)),
        onPressed: () {
          removeFromCardCallBack();
        });
    ;
  }
}
