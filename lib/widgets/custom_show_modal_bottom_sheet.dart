import 'package:flutter/material.dart';

void customShowModalBottomSheet({
  required BuildContext context,
  required WidgetBuilder builder,
  String? title,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close_rounded, size: 18)
                )
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 80),
              child: builder(context),
            )
          ],
        )
      );
    }
  );
}
