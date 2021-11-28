// ignore_for_file: file_names, prefer_const_constructors, unnecessary_this, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'language.dart';

class TranslateInput extends StatefulWidget {
  TranslateInput(
      {Key? key,
        required this.onCloseClicked,
        required this.focusNode,
        required this.firstLanguage,
        required this.secondLanguage})
      : super(key: key);

  final Function(bool) onCloseClicked;
  final FocusNode focusNode;
  final Language firstLanguage;
  final Language secondLanguage;

  @override
  _TranslateInputState createState() => _TranslateInputState();
}

class _TranslateInputState extends State<TranslateInput> {
  TextEditingController _textEditingController = TextEditingController();
  String _textTranslated = "";
  GoogleTranslator _translator = new GoogleTranslator();

  _onTextChanged(String text) {
    if (text != "") {
      _translator
          .translate(text,
          from: this.widget.firstLanguage.code,
          to: this.widget.secondLanguage.code)
          .then((translatedText) {
        this.setState(() {
          this._textTranslated = translatedText.toString();
        });
      });
    } else {
      this.setState(() {
        this._textTranslated = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              child: TextField(
                focusNode: this.widget.focusNode,
                controller: this._textEditingController,
                onChanged: this._onTextChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: RawMaterialButton(
                    onPressed: () {
                      if (this._textEditingController.text != "") {
                        this.setState(() {
                          this._textEditingController.clear();
                          this._textTranslated = "";
                        });
                      } else {
                        this.widget.onCloseClicked(false);
                      }
                    },
                    child: new Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    shape: new CircleBorder(),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this._textTranslated,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
              width:200,
              height:50,
              child: RaisedButton(
                color: Colors.amber,
                onPressed: (){
                  if(this._textEditingController.text != "")
                    this.setState(() {
                      Translation();
                      print("Successfu;");
                    });
                  else
                  {
                    print("Unsuccessful");
                  }



                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.blue,width: 2)
                ),
                textColor:Colors.white,child:Text("Translate"),

              )
          )

        ],
      ),
    );
  }
  Future Translation()  async {
    // url to registration php script
    var APIURL;
    ("https://localhost/localconnect/insertdata.php");
    //json maping user entered details
    Map mapeddate = {
      '_textEditingController': _textEditingController.text,
      '_textTranslated': _textTranslated.toString,

    };
    http.Response reponse = await http.post(APIURL,body:mapeddate);
    var data = jsonDecode(reponse.body);
    print("DATA: ${data}");
  }
}