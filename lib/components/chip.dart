import 'package:flutter/material.dart';

class ChipComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Chip(
          label: Text(
            'Desenvolvedor',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),

          onDeleted: () {},
          backgroundColor: Color(0xff3700b3),
          deleteIcon: Icon(
            Icons.cancel,
            color: Colors.white,
            size: 18,
          ),
          labelPadding: EdgeInsets.only(
            bottom: 2,
            top: 2,
            left: 12,
            right: 2,
          ),
        ),
      ),
    );
  }
}
