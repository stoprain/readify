import 'package:flutter/material.dart';
import 'package:readify/util/preference.dart';

class UnreadSwitchWidget extends StatefulWidget {
  final VoidCallback onChange;
  const UnreadSwitchWidget({super.key, required this.onChange});

  @override
  State<UnreadSwitchWidget> createState() => _UnreadSwitchWidgetState();
}

class _UnreadSwitchWidgetState extends State<UnreadSwitchWidget> {
  bool isUnread = true;

  @override
  initState() {
    var init = Preference.getBool(Preference.UNREAD);
    if (init != null) {
      isUnread = init;
    } else {
      isUnread = true;
      Preference.setBool(Preference.UNREAD, true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(value: true, label: Text('Unread')),
        ButtonSegment(value: false, label: Text('All'))
      ],
      selected: {isUnread},
      onSelectionChanged: (i) => {
        setState(() {
          isUnread = i.first;
          Preference.setBool(Preference.UNREAD, isUnread);
          widget.onChange();
        })
      },
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      ),
    );
  }
}
