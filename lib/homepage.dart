import 'package:flutter/material.dart';

import 'choose-language.dart';
import 'translate-text.dart';
import 'translate-input.dart';
import 'language.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isTextTouched = false;
  Language _firstLanguage = Language('en', 'English');
  Language _secondLanguage = Language('fr', 'French');
  FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this._textFocusNode.dispose();
    super.dispose();
  }

  _onLanguageChanged(Language firstCode, Language secondCode) {
    this.setState(() {
      this._firstLanguage = firstCode;
      this._secondLanguage = secondCode;
    });
  }

  // Generate animations to enter the text to translate
  _onTextTouched(bool isTouched) {
    if (isTouched) {
      FocusScope.of(context).requestFocus(this._textFocusNode);
    } else {
      FocusScope.of(context).requestFocus(new FocusNode());
    }

    this.setState(() {
      this._isTextTouched = isTouched;
    });
  }

  Widget _displaySuggestions() {
    if (this._isTextTouched) {
      return Container(
        color: Colors.black.withOpacity(0.4),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          ChooseLanguage(
            onLanguageChanged: this._onLanguageChanged,
          ),
          Stack(
            children: <Widget>[
              Offstage(
                offstage: this._isTextTouched,
                child: TranslateText(
                  onTextTouched: this._onTextTouched,
                ),
              ),
              Offstage(
                offstage: !this._isTextTouched,
                child: TranslateInput(
                  onCloseClicked: this._onTextTouched,
                  focusNode: this._textFocusNode,
                  firstLanguage: this._firstLanguage,
                  secondLanguage: this._secondLanguage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}