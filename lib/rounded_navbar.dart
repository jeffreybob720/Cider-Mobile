import 'package:flutter/material.dart';

// FIXME: Overflows horizontally when Item doesn't fit
// TODO: Nice Animation when Item is selected

class RoundedNavbarItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const RoundedNavbarItem({
    Key? key,
    required this.icon,
    required this.title,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final col = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Text(
          title,
          style: Theme.of(context).primaryTextTheme.bodySmall,
        ),
      ],
    );

    if (selected) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.zero,
        //padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: col,
      );
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        //padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: col,
    );
  }
}

class RoundedNavbar extends StatefulWidget {
  final List<RoundedNavbarItem> items;
  final Function(int)? onTap;

  const RoundedNavbar({
    Key? key,
    required this.items,
    this.onTap,
  }) : super(key: key);

  @override
  State<RoundedNavbar> createState() => _RoundedNavbarState();
}

class _RoundedNavbarState extends State<RoundedNavbar> {
  var _active = 0;

  @override
  Widget build(BuildContext context) {
    final items = widget.items.map(
      (item) => Expanded(
        child: RoundedNavbarItem(
          icon: item.icon,
          title: item.title,
          selected: _active == widget.items.indexOf(item),
          onTap: () {
            setState(() {
              _active = widget.items.indexOf(item);
            });
            widget.onTap?.call(_active);
          },
        ),
      ),
    );

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...items,
          ],
        ),
      ),
    );
  }
}
