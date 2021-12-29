import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yt/Domain/Models/Recipe.dart';

class Sponaculur {
  String key = "apiKey=8af9998c64f247e8b377dee8aba404fb";

  String recipes = "https://api.spoonacular.com/recipes/complexSearch?";

  Future<List<Recipe>> getData(String recipe) async {
    http.Response response = await http.get(Uri.parse("${recipes}query=$recipe&number=20&addRecipeNutrition=true&$key"));
    Map recivedData = jsonDecode(response.body);
    List<Recipe> data = List.castFrom(recivedData["results"])
        .map((element) => Recipe(
              element["title"],
              element["image"],
              element['nutrition']['nutrients'][0]['amount'].toString(),
              element["nutrition"]["ingredients"],
              element['nutrition']['nutrients'][0]['amount'].toInt(),
              element['pricePerServing'].toInt(),
            ))
        .toList();
    return data;
  }
}
