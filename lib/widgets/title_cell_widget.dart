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
                SizedBox(
                  width: 24,
                  height: 24,
                  child: widget.icon,
                ),
                Text(widget.title),
              ],
            ),
            Text('${widget.unread}'),
          ],
        ),
      ),
      onTap: () {
        widget.onCellTap();
      },
    );
  }
}
