import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListController extends StatefulWidget {
  //const WishListController({ Key? key }) : super(key: key);
  final Function wishListControllerCallBack;
  WishListController({required this.wishListControllerCallBack});
  @override
  _WishListControllerState createState() =>
      _WishListControllerState(wishListControllerCallBack);
}

class _WishListControllerState extends State<WishListController> {
  //_WishListControllerState(Function wishListControllerCallBack);
  final Function wishListControllerCallBack;
  _WishListControllerState(this.wishListControllerCallBack);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        'WISHLIST',
        style: TextStyle(fontSize: 9, color: Colors.black),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(4.0),
        )),
      ),
      onPressed: () {
        wishListControllerCallBack();
      },
    );
  }
}
