import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yt/System/Constants.dart';
import 'package:yt/Layout/Tools/Providers/DataProvider.dart';

class CategoryField extends StatelessWidget {
  final DataProvider listner;

  const CategoryField({Key key, @required this.listner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: 140,
            decoration: BoxDecoration(
              color: (listner.recipe == categoriesList[index]) ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("Icons/${categoriesList[index]}.png"),
                    ),
                  ),
                ),
                Text(
                  categoriesList[index],
                  style: kTextCategoryNameStyle.copyWith(color: (listner.recipe == categoriesList[index]) ? Colors.white : Colors.black),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(color: (listner.recipe == categoriesList[index]) ? Colors.white : Colors.green, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: (listner.recipe == categoriesList[index]) ? Colors.green : Colors.white,
                    ),
                    onPressed: () {
                      listner.setrecipe = categoriesList[index];
                      listner.getData();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
