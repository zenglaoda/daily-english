import 'package:flutter/material.dart';

typedef CusSnapshotBuilder<T> = Widget Function(BuildContext context, T data);

class CusSnapshotWidget<T> extends StatelessWidget {
  final AsyncSnapshot? snapshot;
  final bool loading;
  final bool error;
  final CusSnapshotBuilder<T>? builder;
  final Widget? child;

  CusSnapshotWidget({
    super.key,
    required this.snapshot,
    required this.builder,
    this.child,
  }):
    assert(snapshot != null, 'property snapshot cannot be empty'),
    assert((builder != null || child != null), 'property builder, child cannot be empty at the same time'),
    error = snapshot!.hasError,
    loading = snapshot.connectionState == ConnectionState.waiting;

  const CusSnapshotWidget.custom({ 
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
    if (builder is CusSnapshotBuilder<T>) {
      return builder!(context, snapshot!.data);
    }
    return child!;
  }
}
