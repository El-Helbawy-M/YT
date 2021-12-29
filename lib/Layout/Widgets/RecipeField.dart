import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt/Domain/Models/Recipe.dart';
import 'package:yt/Domain/Models/User.dart';
import 'package:yt/Layout/Screens/RecipeScreen.dart';
import 'package:yt/System/Constants.dart';
import 'package:yt/Layout/Tools/Providers/DataProvider.dart';

class RecipeField extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final AppUser user;
  final DataProvider listner;
  const RecipeField({Key key, @required this.user, @required this.recipe, @required this.index, @required this.listner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => DataProvider(this.user, categoriesList[0], 1),
                  child: Consumer<DataProvider>(builder: (context, listner, child) => RecipeScreen(index: index, recipe: recipe)),
                ),
              ),
            )..then((value) async => await listner.getOrderedList());
          },
          child: Hero(
            tag: index,
            child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            recipe.image,
                          ),
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
                            children: [
                              Text(
                                recipe.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                recipe.grams.toString() + "g",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 5,
                                ),
                                child: Text(
                                  '\$',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                recipe.price.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
