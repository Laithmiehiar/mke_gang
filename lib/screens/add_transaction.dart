// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mke_gang/constants/color_constants.dart';
import 'package:mke_gang/constants/resources.dart';
import 'package:mke_gang/custom_icons/MyFlutterApp.dart';
import 'package:mke_gang/models/User.dart';
import 'package:mke_gang/services/users.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class AddTransaction extends StatelessWidget {
  final MoneyMaskedTextController _amount = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', leftSymbol: '\$');

  AddTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, // elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(backButton, width: 20, height: 20),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.only(left: 8),
        ),
      ),
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        // width: double.infinity,
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40, top: 10),
                          child: Text(
                            "ADD TRANSACTION",
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kGreyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 311,
                        height: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: kWhiteGreyColor,
                                offset: Offset(0, 4),
                                blurRadius: 0)
                          ],
                          color: Color.fromRGBO(
                              204, 229, 255, 0.27000001072883606),
                        ),
                        child: Stack(children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          "Amount",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontSize: 18,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: TextFormField(
                                            controller: _amount,
                                            key: const ValueKey("amount"),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: const InputDecoration(
                                                hintText: "\$ 0.00"),
                                            // controller: _passwordController,
                                          )),
                                    )
                                  ],
                                ),
                              ]),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          'Memo (Optional)',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  132, 135, 140, 1),
                                              fontFamily: 'Comfortaa',
                                              fontSize: 13,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: TextFormField(
                                              key: const ValueKey("amount"),
                                              textAlign: TextAlign.left,
                                              decoration: const InputDecoration(
                                                  hintText: "What’s it for?"),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                              // controller: _passwordController,
                                            )),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          'You have 140 of 140 characters remaning.',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontFamily: 'Comfortaa',
                                              fontSize: 11,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ])),
                  ]),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 350,
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  initialData: [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return AmountsTabs(snapshot, _amount);
                    }
                  },
                ),
              ),
            ])),
      )),
    );
  }
}

class AmountsTabs extends StatefulWidget {
  final checkedValues = <Map>[];
  final AsyncSnapshot snapshot;
  final MoneyMaskedTextController amount;

  AmountsTabs(this.snapshot, this.amount);

  @override
  State<StatefulWidget> createState() => AmountsTabsState(snapshot, amount);
}

class AmountsTabsState extends State<AmountsTabs> {
  late AsyncSnapshot snapshot;
  static const List<Tab> _tabs = [
    const Tab(
        child: Align(
      alignment: Alignment.center,
      child: Text("Equally"),
    )),
    const Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text("Custom"),
      ),
    ),
  ];
  List<TextEditingController> _customValuescontrollers = [];

  AmountsTabsState(AsyncSnapshot snapshot, MoneyMaskedTextController amount) {
    this.snapshot = snapshot;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _customValuescontrollers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: Size.fromHeight(50.0),
                    child: TabBar(
                        // controller: _tabController,
                        padding: EdgeInsets.all(0),
                        unselectedLabelColor: Colors.redAccent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.redAccent),
                        tabs: _tabs),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .snapshots(),
                      initialData: [],
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return TabBarView(children: [
                            Center(
                              child: ListView(
                          children: snapshot.data?.docs.map<Widget>((document) {
                            // widget.checkedValues.putIfAbsent(
                            //     '${document["accountId"]}', () => false);

                            var index = widget.checkedValues.indexWhere(
                                (element) =>
                                    element["accountId"] ==
                                    '${document['accountId']}');
                            //index -1 means user not added to the list, added it once
                            if (index < 0) {
                              widget.checkedValues.add({
                                "accountId": '${document['accountId']}',
                                "selected": false,
                                "amount": 0
                              });
                              index = widget.checkedValues.indexWhere(
                                  (element) =>
                                      element["accountId"] ==
                                      '${document['accountId']}');
                            }
                            return Container(
                                child: CheckboxListTile(
                              title: Text(document['name']),
                              subtitle: Text('${document['accountId']}'),
                              secondary: const Icon(Icons.person),
                              autofocus: true,
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              selected: widget.checkedValues[index]["selected"],
                              value: widget.checkedValues[index]["selected"],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.checkedValues[index]["selected"] =
                                      value;
                                });
                              },
                            ));
                          }).toList(),
                        ),
                      ),
                      Center(
                        child: ListView(
                          children: snapshot.data?.docs.map<Widget>((document) {
                            // widget.checkedValues.putIfAbsent(
                            //     '${document["accountId"]}', () => false);

                            final controller = TextEditingController();

                            var index = widget.checkedValues.indexWhere(
                                (element) =>
                                    element["accountId"] ==
                                    '${document['accountId']}');
                            //index -1 means user not added to the list, added it once
                            if (index < 0) {
                              widget.checkedValues.add({
                                "accountId": '${document['accountId']}',
                                "selected": false,
                                "amount": 0
                              });
                              index = widget.checkedValues.indexWhere(
                                  (element) =>
                                      element["accountId"] ==
                                      '${document['accountId']}');
                            }

                            return Container(
                                child: CheckboxListTile(
                              title: TextFormField(
                                controller: controller,
                                readOnly: widget.checkedValues[index]
                                    ["selected"],
                                decoration: InputDecoration(
                                    labelText: 'Input Form',
                                    hintText: 'placeholder'),
                              ),
                              subtitle: Text('${document['accountId']}'),
                              secondary: const Icon(Icons.person),
                              autofocus: true,
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              selected: widget.checkedValues[index]["selected"],
                              //     checkedValues['${document["accountId"]}']
                              //         as bool,
                              // value: widget.checkedValues[
                              //     '${document["accountId"]}'],
                              value: widget.checkedValues[index]["selected"],
                              onChanged: (bool? value) {
                                setState(() {
                                  // widget.checkedValues.update(
                                  //     '${document["accountId"]}',
                                  //     (val) => value!);
                                  // print(widget.checkedValues[
                                  //     '${document["accountId"]}'] as bool);
                                  // map["selected"] = value;
                                  _customValuescontrollers.add(controller);
                                  widget.checkedValues[index]["selected"] =
                                      value;
                                });
                              },
                            ));
                          }).toList(),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 56,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: kGradientSlideButton,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.mirror,
              stops: const <double>[0.0, 1.0],
            ),
          ),
          child: ConfirmationSlider(
            onConfirmation: () {
              print(widget.amount.numberValue);
            },
            height: 56,
            width: MediaQuery.of(context).size.width - 32,
            backgroundColor: Colors.transparent,
            shadow: BoxShadow(color: Colors.transparent),
            foregroundColor: kWhiteColor,
            foregroundShape: BorderRadius.circular(8),
            icon: MyFlutterApp.slide_icon,
            iconColor: kBlueColor,
            text: 'Slide for Payment',
            textStyle: GoogleFonts.nunito(
                fontSize: 14, color: kWhiteColor, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance.collection("users").snapshots(),
    //     initialData: [],
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (!snapshot.hasData) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    //       // print(categories
    //       //     .length); // 0 when app starts, 6 after state is filled with data

    //       return DefaultTabController(
    //           length: 2,
    //           initialIndex: 0,
    //           child: Scaffold(
    //             body: SafeArea(
    //               child: Column(
    //                 children: [
    //                   PreferredSize(
    //                     preferredSize: Size.fromHeight(50.0),
    //                     child: TabBar(
    //                         padding: EdgeInsets.all(0),
    //                         unselectedLabelColor: Colors.redAccent,
    //                         indicatorSize: TabBarIndicatorSize.label,
    //                         indicator: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(50),
    //                             color: Colors.redAccent),
    //                         tabs: _tabs),
    //                   ),
    //                   Expanded(
    //                     child: TabBarView(children: [
    //                       Center(
    //                         child: ListView(
    //                           children:
    //                               snapshot.data.docs.map<Widget>((document) {
    //                             // widget.checkedValues.putIfAbsent(
    //                             //     '${document["accountId"]}', () => false);

    //                             var index = widget.checkedValues.indexWhere(
    //                                 (element) =>
    //                                     element["accountId"] ==
    //                                     '${document['accountId']}');
    //                             //index -1 means user not added to the list, added it once
    //                             if (index < 0) {
    //                               widget.checkedValues.add({
    //                                 "accountId": '${document['accountId']}',
    //                                 "selected": false,
    //                                 "amount": 0
    //                               });
    //                               index = widget.checkedValues.indexWhere(
    //                                   (element) =>
    //                                       element["accountId"] ==
    //                                       '${document['accountId']}');
    //                             }
    //                             return Container(
    //                                 child: CheckboxListTile(
    //                               title: Text(document['name']),
    //                               subtitle: Text('${document['accountId']}'),
    //                               secondary: const Icon(Icons.person),
    //                               autofocus: true,
    //                               activeColor: Colors.green,
    //                               checkColor: Colors.white,
    //                               selected: widget.checkedValues[index]
    //                                   ["selected"],
    //                               //     checkedValues['${document["accountId"]}']
    //                               //         as bool,
    //                               // value: widget.checkedValues[
    //                               //     '${document["accountId"]}'],
    //                               value: widget.checkedValues[index]
    //                                   ["selected"],
    //                               onChanged: (bool? value) {
    //                                 setState(() {
    //                                   // widget.checkedValues.update(
    //                                   //     '${document["accountId"]}',
    //                                   //     (val) => value!);
    //                                   // print(widget.checkedValues[
    //                                   //     '${document["accountId"]}'] as bool);
    //                                   // map["selected"] = value;

    //                                   widget.checkedValues[index]["selected"] =
    //                                       value;
    //                                   print(widget.checkedValues);
    //                                 });
    //                               },
    //                             ));
    //                           }).toList(),
    //                         ),
    //                       ),
    //                       Center(child: const Text('Content of Tab Two')),
    //                     ]),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ));
    //     });
  }
}
