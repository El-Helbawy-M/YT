import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yt/Layout/Tools/Providers/CartProvider.dart';
import 'package:yt/Layout/Tools/Providers/CriditPaymentProvider.dart';
import 'CheckOutScreen.dart';

class BaymentScreen extends StatefulWidget {
  @override
  _BaymentScreenState createState() => _BaymentScreenState();
}

class _BaymentScreenState extends State<BaymentScreen> {
  @override
  Widget build(BuildContext context) {
    var listner = Provider.of<CartProvider>(context);
    if (listner.check) listner.getCart();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      //=======================
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Your Order",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontFamily: "Modak",
            )),
        elevation: 0,
      ),
      //=======================
      body: Column(
        children: [
          Expanded(
            child: (listner.recipes.length == 0)
                ? Container()
                : Consumer<CartProvider>(
                    builder: (context, listner, child) => ListView.builder(
                      itemCount: listner.recipes.length,
                      itemBuilder: (context, index) => Slidable(
                        key: Key(listner.recipes[index].title),
                        direction: Axis.horizontal,
                        actionPane: SlidableDrawerActionPane(),
                        dismissal: SlidableDismissal(child: SlidableDrawerDismissal(), onDismissed: (actionType) => listner.removeRecipe(index)),
                        actions: [
                          IconSlideAction(
                            foregroundColor: Colors.green,
                            icon: Icons.delete,
                            caption: 'Remove',
                            color: Colors.grey[100],
                            onTap: () => listner.removeRecipe(index),
                          ),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: SizedBox(
                            height: 120,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(listner.recipes[index].image),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [Text(listner.recipes[index].title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              Padding(padding: const EdgeInsets.only(right: 5), child: Text('\$', style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold))),
                                              Text(listner.recipes[index].price.toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          hoverColor: Colors.white,
                                          focusColor: Colors.white,
                                          splashColor: Colors.white,
                                          child: Container(
                                            width: 40,
                                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
                                            child: Center(child: Icon(Icons.arrow_drop_up, color: Colors.white)),
                                          ),
                                          onTap: () => listner.increaseAmount(index),
                                        ),
                                      ),
                                      //=========================
                                      SizedBox(width: 40, height: 40, child: Center(child: Text(listner.recipes[index].amount.toString(), style: TextStyle(fontSize: 17, color: Colors.black)))),
                                      //=========================
                                      Expanded(
                                        child: InkWell(
                                          hoverColor: Colors.white,
                                          focusColor: Colors.white,
                                          splashColor: Colors.white,
                                          child: Container(
                                            width: 40,
                                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),
                                            child: Center(child: Icon(Icons.arrow_drop_down, color: Colors.white)),
                                          ),
                                          onTap: () => listner.decreaseAmount(index),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Text('Total:', style: TextStyle(fontSize: 25, fontFamily: "Modak"))),
                Center(child: Text(listner.total.toString() + " \$", style: TextStyle(fontSize: 25, fontFamily: "Modak"))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 80,
            child: FlatButton(
              child: Center(child: Text("Order", style: TextStyle(color: Colors.white, fontSize: 25))),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider<CriditPaymentProvider>(create: (_) => CriditPaymentProvider(listner.user, listner.total), child: CheckOutScreen()))),
            ),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}
