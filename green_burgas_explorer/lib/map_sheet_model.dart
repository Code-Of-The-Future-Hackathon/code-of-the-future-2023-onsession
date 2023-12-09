import 'package:flutter/material.dart';

class SheetModal extends StatelessWidget {
  final String name;
  final String description;

  const SheetModal({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Add your localization logic or use a package like easy_localization

    bool isOpen = false;

    return Container(
      color: Colors.grey[200], // Replace with your desired background color
      child: SizedBox(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 20),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 20),
                  child: Center(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
