import 'package:flutter/material.dart';

typedef SetState = void Function(VoidCallback fn);

void customShowModalBottomSheet({
  required BuildContext context,
  required StatefulWidgetBuilder builder,
  String? title,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    ),
    builder: (_) {
      return StatefulBuilder(
        // setState 更新 StatefulBuilder
        builder: ((context, setState) => Container(
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
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 18)
                  )
                ],
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 80),
                child: builder(context, setState),
              )
            ],
          )
        ))
      ); 
    }
  );
}

class SheetBodyWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final String? title;
  // 更新
  final SetState? update;

  const SheetBodyWidget({
    super.key, 
    required this.builder,
    this.title,
    this.update
  });

  @override
  State<SheetBodyWidget> createState() => _SheetBodyWidgetState();
}

class _SheetBodyWidgetState extends State<SheetBodyWidget> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(widget.title ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, size: 18)
              )
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: widget.builder(context),
          )
        ],
      )
    );
  }
}

// TODO: 完善数据更新
void customShowModalBottomSheet2({
  required BuildContext context,
  required StatefulWidgetBuilder builder,
  String? title,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    ),
    builder: (_) {
      return StatefulBuilder(
        // setState 更新 StatefulBuilder
        builder: ((context, setState) => Container(
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
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 18)
                  )
                ],
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 80),
                child: builder(context, setState),
              )
            ],
          )
        ))
      ); 
    }
  );
}
