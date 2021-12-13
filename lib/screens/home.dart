// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mke_gang/constants/color_constants.dart';
import 'package:mke_gang/custom_icons/MyFlutterApp.dart';
import 'package:mke_gang/models/CardModel.dart';
import 'package:mke_gang/models/transaction_model.dart';
import 'package:mke_gang/models/wallet_model.dart';
import 'package:mke_gang/screens/add_transaction.dart';
import 'package:mke_gang/services/auth.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Home({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              MyFlutterApp.add,
              color: kBlackColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddTransaction();
              }));
            },
            padding: EdgeInsets.only(left: 8),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: kBlackColor,
              ),
              onPressed: () async {
                final String retVal = await Auth(auth: widget.auth).signOut();
                if (retVal == "Success") {
                  Navigator.pushReplacementNamed(context, "/logout");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(retVal),
                    ),
                  );
                }
              },
              padding: EdgeInsets.only(left: 8),
            ),
          ]),
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            // Card Account Section
            Padding(
              padding: EdgeInsets.only(left: 24, top: 8, bottom: 16),
              child: Text(
                'Hi, Laith!',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kBlackColor,
                ),
              ),
            ),
            Container(
              height: 175,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 175,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: cards[index].bgColor,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 10,
                              spreadRadius: 4,
                              offset: Offset(0.0, 8.0))
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 16,
                            top: 12,
                            child: Image.asset(
                              cards[index].type,
                              height: 22,
                              width: 33,
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 12,
                            child:
                                SvgPicture.asset(cards[index].cardBackground),
                          ),
                          // Positioned(
                          //   top: 14,
                          //   right: 12,
                          //   child: Text(
                          //     cards[index].name,
                          //     style: GoogleFonts.nunito(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.w400,
                          //         color: cards[index].firstColor),
                          //   ),
                          // ),
                          Positioned(
                            top: 63,
                            left: 16,
                            child: Text(
                              cards[index].title,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: cards[index].firstColor),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 81,
                            child: Text(
                              '\$ ' + cards[index].balance,
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: cards[index].secondColor),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 30,
                            child: Text(
                              'Valid Thru',
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: cards[index].firstColor),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 12,
                            child: Text(
                              cards[index].valid,
                              style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: cards[index].secondColor),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: SvgPicture.asset(
                              cards[index].moreIcon,
                              height: 24,
                              width: 24,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),

            // Last Transaction Section
            Padding(
                padding:
                    EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Last Transactions',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kBlackColor,
                      ),
                    ),
                    Text(
                      'See all transactions',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kBlueColor,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 190,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 8),
                scrollDirection: Axis.horizontal,
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 190,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kWhiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x04000000),
                            blurRadius: 10,
                            spreadRadius: 10,
                            offset: Offset(0.0, 8.0))
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 16,
                          left: 16,
                          child: SvgPicture.asset(transactions[index].type),
                          height: 24,
                          width: 24,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child:
                              SvgPicture.asset('assets/svg/mastercard_bg.svg'),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Text(
                            transactions[index].name,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: transactions[index].colorType),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          left: 16,
                          child: Text(
                            transactions[index].signType +
                                'Rp ' +
                                transactions[index].amount,
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: transactions[index].colorType),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 106,
                          child: Text(
                            transactions[index].information,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 48,
                          child: Text(
                            transactions[index].recipient,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: kBlackColor),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 22,
                          child: Text(
                            transactions[index].date,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor),
                          ),
                        ),
                        Positioned(
                          right: 14,
                          bottom: 16,
                          child: Image.asset(
                            transactions[index].card,
                            height: 22,
                            width: 33,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // Top Up Section
            Padding(
              padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
              child: Text(
                'Top Up Again',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kBlackColor,
                ),
              ),
            ),
            Container(
              height: 304,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 16),
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 68,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x04000000),
                              blurRadius: 10,
                              spreadRadius: 10,
                              offset: Offset(0.0, 8.0))
                        ],
                        color: kWhiteColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhiteGreyColor,
                                image: DecorationImage(
                                  image: AssetImage(wallets[index].walletLogo),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  wallets[index].name,
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: kBlackColor),
                                ),
                                Text(
                                  wallets[index].wallet,
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: kGreyColor),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              wallets[index].walletNumber,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kGreyColor),
                            ),
                            SizedBox(
                              width: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
