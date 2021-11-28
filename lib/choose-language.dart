// ignore_for_file: file_names, unnecessary_this, prefer_const_constructors, prefer_const_constructors_in_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import 'language.dart';
import 'language-page.dart';

class ChooseLanguage extends StatefulWidget {
  ChooseLanguage({Key? key, required this.onLanguageChanged}) : super(key: key);
  final Function(
      Language firstCode,
      Language secondCode,
      ) onLanguageChanged;
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  Language _firstLanguage = Language('en', 'English');
  Language _secondLanguage = Language('fr', 'French');

  void _switchLanguage() {
    Language _tmpLanguage = this._firstLanguage;

    setState(() {
      this._firstLanguage = this._secondLanguage;
      this._secondLanguage = _tmpLanguage;
    });
    this.widget.onLanguageChanged(this._firstLanguage, this._secondLanguage);
  }

  void _chooseFirstLanguage(String title) async {
    final language = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LanguagePage(
          title: title,
        ),
      ),
    );

    if (language != null) {
      this.setState(() {
        this._firstLanguage = language;
      });
      this.widget.onLanguageChanged(this._firstLanguage, this._secondLanguage);
    }
  }

  // Choose a new second language
  void _chooseSecondLanguage(String title) async {
    final language = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LanguagePage(
          title: title,
        ),
      ),
    );

    if (language != null) {
      this.setState(() {
        this._secondLanguage = language;
      });
      this.widget.onLanguageChanged(this._firstLanguage, this._secondLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        color: Colors.white,
        // ignore: prefer_const_constructors
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  this._chooseFirstLanguage("Translate from");
                },
                child: Center(
                  child: Text(
                    this._firstLanguage.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.compare_arrows,
                color: Colors.grey[600],
              ),
              onPressed: () {
                this._switchLanguage();
              },
//              onPressed: this._switchLanguage,
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  this._chooseSecondLanguage("Translate To");
                },
                child: Center(
                  child: Text(
                    this._secondLanguage.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
