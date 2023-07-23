abstract class ActionCategories {}

class ActionCategoriesInit extends ActionCategories {}

class ActionCategoriesPullState extends ActionCategories {}

class ActionCategoriesLoad extends ActionCategories {}

class ActionCategoriesClear extends ActionCategories {}

class ActionCategoriesChoose extends ActionCategories {
  final String category;

  ActionCategoriesChoose({this.category = ''});
}
