sealed class FoodIntent{
  const FoodIntent();
}
final class FoodInitializationIntent extends FoodIntent{
  const FoodInitializationIntent();
}
final class ChangeMealByCategory extends FoodIntent{
  final String categoryName;
  const ChangeMealByCategory({required this.categoryName});
}