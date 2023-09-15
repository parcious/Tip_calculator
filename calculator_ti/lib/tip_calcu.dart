import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  int _tippercentage = 0;
  int _personCounter = 1;
  double _BillAmount = 0.0;
  Color _purple = HexColor("#EABFFF");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tip_Calculator"),
        centerTitle: true,
      ),
      body: Container(
        //> decoration: BoxDecoration(
        // image: DecorationImage(image: AssetImage("assets/night_moon.jpg"))),
        margin: EdgeInsetsDirectional.only(
            top: MediaQuery.of(context).size.height * 0.03),
        alignment: Alignment.center,
        // height: 160,
        //width: 400,
        // margin: EdgeInsets.all(10),
        color: Colors.transparent,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Container(
              height: 120,
              width: 180,
              //color: HexColor('#EABFFF'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: HexColor('#EABFFF'),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Per Person",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        color: Colors.purple),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "\$ ${calculateToTotalperPerson(_BillAmount, _personCounter, _tippercentage)}",
                      style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 155, 21, 21),
                border: Border.all(style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                        prefixText: "Bill Amount : ",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String Value) {
                      try {
                        _BillAmount = double.parse((Value));
                      } catch (e) {
                        _BillAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _purple),
                              child: Center(
                                child: Text(
                                  " - ",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _purple),
                              child: Center(
                                child: Text(
                                  " + ",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "\$${calculateTotalTip(_BillAmount, _personCounter, _tippercentage)}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  //sliderr
                  Column(
                    children: [
                      Text("$_tippercentage%",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tippercentage.toDouble(),
                          onChanged: (double newvalue) {
                            setState(() {
                              _tippercentage = newvalue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateToTotalperPerson(double billAmount, int SplitBy, int tippercentage) {
    var Totalperperson =
        (calculateTotalTip(billAmount, SplitBy, tippercentage) + billAmount) /
            SplitBy;
    return Totalperperson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int SplitBy, int tippercentage) {
    double TotalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == Null) {
    } else {
      TotalTip = (billAmount * tippercentage) / 100;
    }
    return TotalTip;
  }
}
