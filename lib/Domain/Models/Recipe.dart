class Recipe {
  String title, image, calores;
  int grams, price, amount;
  List<dynamic> ingredients;

  Recipe(this.title, this.image, this.calores, this.ingredients, this.grams, this.price);
  Recipe.forCart(this.title, this.image, this.calores, this.ingredients, this.grams, this.price, this.amount);
  factory Recipe.forCartWithInstance(Recipe recipe, int amount) => Recipe.forCart(recipe.title, recipe.image, recipe.calores, recipe.ingredients, recipe.grams, recipe.price, amount);
  Map<String, Map<String, dynamic>> get details => {
        this.title: {"Calores": this.calores, "Grams": this.grams, "Price": this.price, "Image": this.image, "Amount": this.amount}
      };
}
