import 'package:danim/views/timeline_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/timeline_list_view_model.dart';

class TimelineListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimelineListViewModel>(
      create: (_) => TimelineListViewModel(),
      child: Consumer<TimelineListViewModel>(
        builder: (context, viewModel, child) => ListView.builder(
          itemCount: viewModel.timelineList.length,
          itemBuilder: (context, index) {
            return TimelineListItem(
              key: Key(viewModel.timelineList[index].timelineId.toString()),
              timeline: viewModel.timelineList[index],
            );
          },
        ),
      ),
    );
  }
}