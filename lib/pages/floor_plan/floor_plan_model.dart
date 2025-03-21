import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'floor_plan_widget.dart' show FloorPlanWidget;
import 'package:flutter/material.dart';

class FloorPlanModel extends FlutterFlowModel<FloorPlanWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
