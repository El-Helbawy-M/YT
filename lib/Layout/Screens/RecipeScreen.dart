import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yt/Domain/Models/Recipe.dart';
import 'package:yt/Layout/Widgets/OrderBar.dart';
import 'package:yt/System/Constants.dart';
import 'package:yt/Layout/Tools/Providers/DataProvider.dart';

typedef Map<String, int> DscType();

class RecipeScreen extends StatefulWidget {
  RecipeScreen({this.recipe, this.index});
  final Recipe recipe;
  final int index;
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}



class _RecipeScreenState extends State<RecipeScreen> {
  //==============================================
  String ingredientsDiscraprion(List list) {
    String str = '';
    for (int x = 0; x < list.length; x++) (x == 0) ? str += list[x]["name"] : str += " - " + list[x]["name"];
    return str;
  }

  int index = 0;

  @override
  Widget build(BuildContext cont) {
    //===========================================
    var listner = Provider.of<DataProvider>(cont);
    int a;
    a.floor();
    //===========================================

    return Scaffold(
        //----------------------------------------
        backgroundColor: Colors.white,
        //----------------------------------------
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        //----------------------------------------
        body: Builder(
            builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Hero(
                          tag: widget.index,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 300,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.green,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 270,
                                      width: 270,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.green,
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 250,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(widget.recipe.image),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height: 350,
                          ),
                        ),
                        //=========================
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(cont).size.width / 2,
                                    child: Text(
                                      widget.recipe.title,
                                      style: kRecipeTextStye,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.recipe.grams.toString() + " - " + widget.recipe.calores + " cal",
                                        style: kRecipeTextStye.copyWith(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: FaIcon(
                                          FontAwesomeIcons.fire,
                                          color: Colors.orange,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                child: Row(
                                  children: [
                                    //=========================
                                    Consumer<DataProvider>(
                                      builder: (context, listner, child) => Expanded(
                                        child: InkWell(
                                          hoverColor: Colors.white,
                                          focusColor: Colors.white,
                                          splashColor: Colors.white,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '-',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () => listner.decrease(),
                                        ),
                                      ),
                                    ),
                                    //=========================
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          listner.counter.toString(),
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //=========================
                                    Consumer<DataProvider>(
                                      builder: (context, listner, child) => Expanded(
                                        child: InkWell(
                                          hoverColor: Colors.white,
                                          focusColor: Colors.white,
                                          splashColor: Colors.white,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '+',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () => listner.increase(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //=========================
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Ingredients",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        //=========================
                        Text(
                          ingredientsDiscraprion(widget.recipe.ingredients),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        //=========================
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: FlatButton.icon(
                              onPressed: () async {
                                listner.addOrder(widget.recipe.title);
                                RequestState state = await listner.handler.addRecipe(Recipe.forCartWithInstance(widget.recipe, listner.orderedList[widget.recipe.title]).details);
                                if (state == RequestState.OK) ScaffoldMessenger.of(context).showSnackBar(orderBar("${widget.recipe.title} has been added"));
                              },
                              icon: Icon(Icons.shopping_cart),
                              label: Text("Add"),
                              color: Colors.green,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))

        //----------------------------------------
        );
  }
}

class MyCustom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, 150);
    path.quadraticBezierTo(size.width / 4, 250, size.width / 2, 250);
    path.lineTo(size.width / 2, 250);
    path.quadraticBezierTo(size.width * (3 / 4), 250, size.width, 150);
    path.lineTo(size.width, 150);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
