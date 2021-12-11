import 'package:flutter/material.dart';

class SearchController extends StatefulWidget {
  // const SearchController({Key? key}) : super(key: key);
  String hintText;
  final Function searchTextfieldCallBack;
  SearchController(
      {required this.searchTextfieldCallBack, required this.hintText});

  @override
  _SearchControllerState createState() =>
      _SearchControllerState(searchTextfieldCallBack, hintText);
}

class _SearchControllerState extends State<SearchController> {
  // SearchController({this.searchTextfieldCallBack});
  String hintText;
  final Function searchTextfieldCallBack;
  final FocusNode _focusNode = FocusNode();

  _SearchControllerState(this.searchTextfieldCallBack, this.hintText);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: TextField(
          onChanged: (value) {
            searchTextfieldCallBack(value);
          },
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(2),
              hintText: hintText,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _focusNode.hasFocus
                          ? Colors.grey.shade600
                          : Colors.grey.shade500))),
        ));
  }
}
