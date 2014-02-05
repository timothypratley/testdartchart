import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';


@CustomTag('my-chart')
class MyChart extends PolymerElement {
  static final init = InitViz();
  
  static Future InitViz() {
    Completer c = new Completer();
    context["google"].callMethod('load',
        ['visualization', '1', new JsObject.jsify({
          'packages': 'corechart',
          'callback': new JsFunction.withThis(c.complete)
        })]);
    return c.future;
  }
  
  MyChart.created() : super.created() {
    init.then(Create);
  }
  
  Create(x) {
    final vis = context["google"]["visualization"];
    HttpRequest.request("https://www3.v1host.com/Tideworks/VersionOne/rest-1.v1/Data/Timebox?sel=Name")
    .then((data) => print(data));
    final data = [['Sprint', 'Points'], ["TC1301", 34], ["TC1302", 37]];
    var jsTable = vis.callMethod('arrayToDataTable', [new JsObject.jsify(data)]);
    var me = this.$['me'];
    var jsChart = new JsObject(vis["LineChart"], [me]);
    var jsOptions = new JsObject.jsify({});
    jsChart.callMethod('draw', [jsTable, jsOptions]);
  }
}
