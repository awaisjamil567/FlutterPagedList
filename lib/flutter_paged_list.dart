library flutter_paged_list;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef FutterPageBuilder<T> = Future<List<T>> Function(int offset);

class FlutterPagedList<T> extends StatefulWidget {

  List<T> itemList = <T>[];
  final int pageSize;
  final Widget Function(BuildContext, T) itemBuilder;
  final FutterPageBuilder onfetchNextPage;
  final Widget onLoading;
  int currentPage = 0;

  FlutterPagedList({Key key, this.itemList, this.pageSize, this.itemBuilder, this.onfetchNextPage, this.onLoading, }) : super(key: key);

  @override
  _FlutterPagedListState createState() => _FlutterPagedListState();
}

class _FlutterPagedListState extends State<FlutterPagedList> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && widget.currentPage == widget.itemList.length/widget.pageSize-1) {
          setState(() {
            isLoading = true;
          });
          widget.onfetchNextPage(widget.itemList.length).then((items) =>{
            setState(() {
              isLoading = false;
              widget.currentPage++;
            }),
            widget.itemList.addAll(items)
          });
        }
        return true;
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: (widget.itemList != null && widget.itemList.isNotEmpty) ? widget.itemList.length + 1 : 0,
        itemBuilder: (context, index) {
          if(isLoading && index == widget.itemList.length) {
            return widget.onLoading;
          }
          if(index < widget.itemList.length)
            return widget.itemBuilder(context, widget.itemList[index]);
          else return Container();
        },
      ),
    );
  }
}


