import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

class SCHomeInforNoImageItem extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onTap;

  const SCHomeInforNoImageItem({super.key, 
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      color: SCColors.color_FFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: SCColors.color_1B1D33),
            maxLines: 2, // 最多显示两行
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 15),

          Text(
            date,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99),

            maxLines: 1, // 只显示一行
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
