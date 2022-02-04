import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';

Decoration decoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      style: BorderStyle.solid,
      color: Colors.black26,
    ),
    bottom: BorderSide(
      style: BorderStyle.solid,
      color: Colors.black26,
    ),
  ),
);

Future<StringPicker> testNumberPicker({
  required WidgetTester tester,
  required List<String> values,
  required int initialValue,
  required int scrollBy,
  int step = 1,
  TextMapper? textMapper,
  required int expectedValue,
  Axis axis = Axis.vertical,
  Decoration? decoration,
}) async {
  int value = initialValue;
  late StringPicker picker;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      picker = axis == Axis.vertical
          ? picker = StringPicker(
              values: values,
              value: value,
              step: step,
              textMapper: textMapper,
              decoration: decoration,
              onChanged: (newValue) => setState(() => value = newValue),
            )
          : StringPicker(
              axis: Axis.horizontal,
              value: value,
              values: values,
              step: step,
              textMapper: textMapper,
              decoration: decoration,
              onChanged: (newValue) => setState(() => value = newValue),
            );
      return MaterialApp(
        home: Scaffold(
          body: picker,
        ),
      );
    }),
  );
  expect(value, equals(initialValue));

  await scrollNumberPicker(Offset(0.0, 0.0), tester, scrollBy, axis);
  await tester.pumpAndSettle();

  expect(value, equals(expectedValue));

  return picker;
}

Future<StringPicker> testMultipleValuesInPicker({
  required WidgetTester tester,
  required List<String> values,
  required int initialValue,
  required int scrollBy,
  int step = 1,
  TextMapper? textMapper,
  bool animateToItself = false,
  Axis axis = Axis.vertical,
  bool zeroPad = false,
  required List<String> expectedDisplayValues,
}) async {
  int value = initialValue;
  late StringPicker picker;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      picker = axis == Axis.vertical
          ? picker = StringPicker(
              value: value,
              values: values,
              step: step,
              textMapper: textMapper,
              onChanged: (newValue) => setState(() => value = newValue),
              zeroPad: zeroPad,
            )
          : StringPicker(
              value: value,
              values: values,
              step: step,
              textMapper: textMapper,
              zeroPad: zeroPad,
              onChanged: (newValue) => setState(() => value = newValue),
            );
      return MaterialApp(
        home: Scaffold(
          body: picker,
        ),
      );
    }),
  );
  expect(value, equals(initialValue));

  await scrollNumberPicker(Offset(0.0, 0.0), tester, scrollBy, axis);
  await tester.pumpAndSettle();

  for (String displayValue in expectedDisplayValues) {
    expect(find.text(displayValue), findsOneWidget);
  }

  return picker;
}

scrollNumberPicker(
  Offset pickerPosition,
  WidgetTester tester,
  int scrollBy,
  Axis axis,
) async {
  double pickerCenterX, pickerCenterY, offsetX, offsetY;
  double pickerCenterMainAxis = 1.5 * (axis == Axis.vertical ? 50 : 100);
  double pickerCenterCrossAxis = (axis == Axis.vertical ? 100 : 50) / 2;
  if (axis == Axis.vertical) {
    pickerCenterX = pickerCenterCrossAxis;
    pickerCenterY = pickerCenterMainAxis;
    offsetX = 0.0;
    offsetY = -scrollBy * 50;
  } else {
    pickerCenterX = pickerCenterMainAxis;
    pickerCenterY = pickerCenterCrossAxis;
    offsetX = -scrollBy * 100;
    offsetY = 0.0;
  }
  Offset pickerCenter = Offset(
    pickerPosition.dx + pickerCenterX,
    pickerPosition.dy + pickerCenterY,
  );
  final TestGesture testGesture = await tester.startGesture(pickerCenter);
  await testGesture.moveBy(Offset(
    offsetX,
    offsetY,
  ));
}
