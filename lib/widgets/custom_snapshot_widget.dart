import 'package:flutter/material.dart';

typedef CustomSnapshotBuilder<T> = Widget Function(BuildContext context, T data);

class CustomSnapshotWidget<T> extends StatelessWidget {
  final AsyncSnapshot? snapshot;
  final bool loading;
  final bool error;
  final CustomSnapshotBuilder<T>? builder;
  final Widget? child;

  CustomSnapshotWidget({
    super.key,
    required this.snapshot,
    required this.builder,
    this.child,
  }):
    assert(snapshot != null, 'property snapshot cannot be empty'),
    assert((builder != null || child != null), 'property builder, child cannot be empty at the same time'),
    error = snapshot!.hasError,
    loading = snapshot.connectionState == ConnectionState.waiting;

  const CustomSnapshotWidget.custom({ 
    super.key,
    required this.child,
    bool? loading,
    bool? error
  }):
    assert((child != null), 'property child cannot be empty'),
    snapshot = null,
    builder = null,
    loading = loading ?? false,
    error = error ?? false;


  @override
  Widget build(BuildContext context) {
    if (error) {
      return const Center(
        child: Text('数据加载失败'),
      );
    }
    if (loading) {
      return const Center(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding:EdgeInsets.only(top: 16),
                child: Text('加载中...', style: TextStyle(color: Color(0xff999999))),
              )
            ],
          ),
        )
      );
    }
    if (builder is CustomSnapshotBuilder<T>) {
      return builder!(context, snapshot!.data);
    }
    return child!;
  }
}
