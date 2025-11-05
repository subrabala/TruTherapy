import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart';
import 'package:parchment/parchment.dart';

class DeltaTextView extends StatelessWidget {
  final String deltaJson;
  final TextStyle? defaultStyle;

  const DeltaTextView({
    Key? key,
    required this.deltaJson,
    this.defaultStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      // Parse the delta JSON string into a list of operations
      final List<dynamic> deltaOps = json.decode(deltaJson);
      
      // Create a ParchmentDocument from the delta operations
      final delta = Delta.fromJson(deltaOps);
      final document = ParchmentDocument.fromDelta(delta);

      // Return a read-only Fleather editor
      return Container(
        padding: EdgeInsets.zero,
        child: FleatherEditor(
          controller: FleatherController(document: document),
          readOnly: true, // Make it read-only since this is for viewing only
          padding: EdgeInsets.zero,
          focusNode: FocusNode(), // Prevent keyboard focus
        ),
      );
    } catch (e) {
      // Fallback to plain text if parsing fails
      return Text(
        deltaJson,
        style: defaultStyle ?? const TextStyle(fontSize: 14),
      );
    }
  }
}