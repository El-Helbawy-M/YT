import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Domain/Models/Recipe.dart';
import 'package:yt/Layout/Tools/Providers/CartProvider.dart';
import 'package:yt/Layout/Widgets/AppDrawer.dart';
import 'package:yt/Layout/Widgets/CategoryField.dart';
import 'package:yt/Layout/Widgets/OrderBar.dart';
import 'package:yt/Layout/Widgets/RecipeField.dart';
import 'package:yt/System/Constants.dart';
import 'package:yt/Layout/Tools/Providers/DataProvider.dart';
import 'BaymentScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var listner = Provider.of<DataProvider>(context);
    if (listner.data.isEmpty) listner.getData();
    if (listner.check) listner.getOrderedList();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      //============================
      drawer: appDrawer(context, listner.user),
      //============================
      key: key,
      //============================
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => key.currentState.openDrawer(),
        ),
        title: Text('YT', style: TextStyle(color: Colors.black, fontFamily: "Modak", fontSize: 25)),
        actions: [
          Consumer<DataProvider>(
            builder: (contex, listner, child) => Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.black, size: 30),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider(listner.user), child: BaymentScreen())),
                  ).then((value) async => await listner.getOrderedList()),
                ),
                if (listner.orders != 0)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      padding: EdgeInsets.all(5),
                      child: Text(listner.orders.toString(), style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      //============================
      body: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), child: Text("Categories", style: kTextTitleStyle)),
            //=============================
            Consumer<DataProvider>(builder: (context, listner, child) => CategoryField(listner: listner)),
            //=============================
            Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), child: Text("Popular Now", style: kTextTitleStyle)),
            //=============================
            Consumer<DataProvider>(
              builder: (context, listner, child) => Expanded(
                  child: listner.data.isNotEmpty
                      ? ListView.builder(
                          itemCount: listner.data.length,
                          itemBuilder: (context, index) {
                            //=================================================
                            Recipe recipe = listner.data[index];
                            //=================================================
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                              child: Stack(
                                overflow: Overflow.clip,
                                alignment: Alignment.bottomRight,
                                children: [
                                  Consumer<DataProvider>(builder: (context, listner, child) => RecipeField(user: listner.user, recipe: recipe, index: index, listner: listner)),
                                  //=============================
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: () async {
                                            listner.addOrder(recipe.title);
                                            RequestState state = await listner.handler.addRecipe(Recipe.forCartWithInstance(recipe, listner.orderedList[recipe.title]).details);
                                            if (state == RequestState.OK) ScaffoldMessenger.of(context).showSnackBar(orderBar("${recipe.title} has been added"));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
      //============================
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: listner.index,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text(""),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       title: Text(""),
      //     ),
      //   ],
      // ),
    );
  }
}
