import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dayily_event_agenda_widget.dart' show DayilyEventAgendaWidget;
import 'package:flutter/material.dart';

class DayilyEventAgendaModel extends FlutterFlowModel<DayilyEventAgendaWidget> {
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
