import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../common/styles.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.category,
    required this.imagePath,
  });

  final Category category;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: onPrimaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Image.asset(
              imagePath,
              height: 100,
              width: 100,
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 16),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
