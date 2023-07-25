import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

class SCHomeInforImageItem extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final VoidCallback onTap;

  const SCHomeInforImageItem({
    super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 处理点击事件
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
          height: 93,
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 24),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: SCColors.color_1B1D33),
                        maxLines: 2, // 最多显示两行
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
              ),
              const SizedBox(width: 12),
              // Image.asset(
              //   image,
              //   width: 112.0,
              //   height: 75.0,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(
                width: 112,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
