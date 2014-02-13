import 'dart:core';
import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';

const Tau = PI * 2;
var es = [querySelector('#s0'),
          querySelector('#s1'),
          querySelector('#s2'),
          querySelector('#s3'),
          querySelector('#s4'),
          querySelector('#s5'),
          querySelector('#s6'),
          querySelector('#s7'),
          querySelector('#s8'),
          querySelector('#s9')];
var total = querySelector('#t');


double phi(t, period) {
  return cos(Tau * (t/period));
}

double tick = 0.0;
void handleTimeout(Timer t) {
  tick += 0.001;
  double sum = 0.0;
  for (var i=0; i<10; i++) {
    var v = 50*(1+phi(tick, 1/(i+46)));
    es[i].value = v.toString();
    sum += v;
  }
  total.value = (sum/10.0).toString();
}

void main() {
  initPolymer();
  new Timer.periodic(new Duration(milliseconds: 30), handleTimeout);
}
