import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Data/Api/Checkout.dart';
import 'package:yt/Layout/Tools/Providers/CriditPaymentProvider.dart';
import 'package:yt/System/Constants.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  void initState() {
    super.initState();
    CheckOut.init();
  }

  @override
  Widget build(BuildContext context) {
    var listner = Provider.of<CriditPaymentProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      //======================
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      //======================
      body: Builder(
        builder: (context) => Padding(
            padding: const EdgeInsets.all(10),
            child: (!listner.loading)
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: Text(
                            "Payment Method",
                            style: kPaymentTextStyle,
                          ),
                        ),
                        //======================
                        Consumer<CriditPaymentProvider>(
                          builder: (context, listner, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(onTap: () => listner.changeCardType(CardType.Visa), child: CriditCard(image: "Icons/visa.png", check: listner.cardType == CardType.Visa)),
                              GestureDetector(onTap: () => listner.changeCardType(CardType.MasterCard), child: CriditCard(image: "Icons/MasterCard.png", check: listner.cardType == CardType.MasterCard)),
                              GestureDetector(onTap: () => listner.changeCardType(CardType.Discover), child: CriditCard(image: "Icons/Discover.png", check: listner.cardType == CardType.Discover)),
                            ],
                          ),
                        ),
                        //======================
                        Padding(padding: const EdgeInsets.only(top: 30, bottom: 20), child: Text("Payment Details", style: kPaymentTextStyle)),
                        //======================
                        Padding(padding: const EdgeInsets.symmetric(vertical: 15), child: TextField(decoration: kTextFieldStyle(label: "Cardholder", hint: "Your Name", icon: Icons.person_pin))),
                        //======================
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Consumer<CriditPaymentProvider>(
                            builder: (context, listner, child) => TextField(
                              decoration: kTextFieldStyle(label: "Card Numper", hint: "The Numper", icon: Icons.credit_card),
                              onChanged: (value) => listner.setNumber = value,
                            ),
                          ),
                        ),
                        //======================
                        Consumer<CriditPaymentProvider>(
                          builder: (context, listner, child) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: TextField(
                              decoration: kTextFieldStyle(
                                label: "The Date",
                                hint: "MM/YY",
                                icon: Icons.calendar_today,
                              ),
                              onChanged: (value) => listner.setMonthAndYear(
                                10,
                                2021,
                              ),
                            ),
                          ),
                        ),
                        //======================
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 60,
                            child: FlatButton(
                              onPressed: () async => await listner.pay(context),
                              child: Center(child: Text("Pay", style: kPaymentTextStyle.copyWith(color: Colors.white))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator())),
      ),
    );
  }
}

class CriditCard extends StatefulWidget {
  const CriditCard({this.image, this.check});
  final image;
  final bool check;

  @override
  _CriditCardState createState() => _CriditCardState();
}

class _CriditCardState extends State<CriditCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: (widget.check) ? Color(0xFF9EF0B2) : Colors.white,
        border: Border.all(
          width: 1,
          color: (widget.check) ? Color(0xFF15E70E) : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(image: AssetImage(widget.image)),
      ),
    );
  }
}
