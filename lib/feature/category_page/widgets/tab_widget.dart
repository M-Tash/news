import 'package:flutter/material.dart';
import 'package:news_app/feature/category_page/widgets/tab_item.dart';
import 'package:news_app/feature/news_page/news_widget_view.dart';

import '../../../model/SourceResponse.dart';

class TabWidget extends StatefulWidget {
  final List<Source> sourceList;

  const TabWidget({super.key, required this.sourceList});

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
          indicator: const BoxDecoration(
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
            physics: const NeverScrollableScrollPhysics(),
            children: widget.sourceList.map((source) {
              return NewsWidget(source: source);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
