import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SCHomeInforNoImageItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  SCHomeInforNoImageItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            'Time',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
