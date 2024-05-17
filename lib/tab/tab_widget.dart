import 'package:flutter/material.dart';
import 'package:news_app/news/news_widget.dart';
import 'package:news_app/tab/tab_item.dart';

import '../model/SourceResponse.dart';

class TabWidget extends StatefulWidget {
  final List<Source> sourceList;

  TabWidget({required this.sourceList});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.sourceList.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: BoxDecoration(
            color: Colors.transparent,
          ),
          tabs: widget.sourceList.map((source) {
            int index = widget.sourceList.indexOf(source);
            return TabItem(
              source: source,
              isSelected: index == _tabController.index,
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.sourceList.map((source) {
              return NewsWidget(source: source);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
