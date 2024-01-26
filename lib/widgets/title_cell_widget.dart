import 'package:flutter/material.dart';

class TitleCellWidget extends StatefulWidget {
  final Icon icon;
  final String title;
  final int unread;
  final VoidCallback onCellTap;
  const TitleCellWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.unread,
      required this.onCellTap});

  @override
  State<TitleCellWidget> createState() => _TitleCellWidgetState();
}

class _TitleCellWidgetState extends State<TitleCellWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        constraints: const BoxConstraints(
            minHeight: 40, minWidth: double.infinity, maxHeight: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: widget.icon,
                  ),
                ),
                Text(widget.title),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.blue,
              ),
              child: Text(
                ' ${widget.unread} ',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        widget.onCellTap();
      },
    );
  }
}
