import 'dart:async';
import 'package:flutter/material.dart';


class CustomSnapshotWidget extends StatelessWidget {
  final bool loading;
  final bool error;
  final Widget content;

  CustomSnapshotWidget({
    super.key,
    required AsyncSnapshot snapshot,
    required this.content
  }):
    error = snapshot.hasError,
    loading = snapshot.hasData ? false : true;

  const CustomSnapshotWidget.custom({ 
    super.key,
    required this.content,
    bool? loading,
    bool? error
  }):
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
    return content;
  }
}
