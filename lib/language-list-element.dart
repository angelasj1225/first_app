// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'language.dart';

class LanguageListElement extends StatefulWidget {
  LanguageListElement(
      {Key? key, required this.language, required this.onSelect})
      : super(key: key);

  final Language language;
  final Function(Language) onSelect;

  @override
  _LanguageListElementState createState() => _LanguageListElementState();
}

class _LanguageListElementState extends State<LanguageListElement> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.widget.language.name),
      onTap: () {
        this.widget.onSelect(this.widget.language);
      },
    );
  }
}
