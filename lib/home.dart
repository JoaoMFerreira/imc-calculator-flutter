import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Enter your data!";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetValues() {
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "Enter your data!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      String imcString = imc.toStringAsPrecision(4);
      if (imc < 18.6) {
        _infoText = "Under weight ($imcString)";
      }
      if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Ideal weight ($imcString)";
      }

      if (imc >= 24.9 && imc <= 29.9) {
        _infoText = "Little overweight ($imcString)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          child: buildColumn(),
          key: _formKey,
        ),
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("IMC Calculator"),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _resetValues,
          color: Colors.white,
        )
      ],
    );
  }

  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Icon(Icons.person_outline, size: 120.0, color: Colors.green),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Weight (Kg)",
              labelStyle: TextStyle(color: Colors.green)),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25.0),
          controller: weightController,
          validator: (value) {
            if(value.isEmpty)
              return "Enten your weight!";
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: "Height (Cm)",
              labelStyle: TextStyle(color: Colors.green)),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25.0),
          controller: heightController,
          validator: _validateWeight,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
              child: RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _calculateIMC();
                  }
                },
                child: Text("Calculate",
                    style: TextStyle(color: Colors.white, fontSize: 25.0)),
                color: Colors.green,
              ),
              height: 50.0),
        ),
        Text(
          _infoText,
          style: TextStyle(color: Colors.green, fontSize: 25.0),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  String _validateWeight(value) {
    if(value.isEmpty)
      return "Enter your height!";
    }

}
