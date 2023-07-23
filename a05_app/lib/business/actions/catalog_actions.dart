
abstract class ActionCatalog {}

class ActionCatalogInit extends ActionCatalog {}

class ActionCatalogPullState extends ActionCatalog {}

class ActionCatalogClear extends ActionCatalog {}

class ActionCatalogLoadMore extends ActionCatalog {
  final int skip;
  final int limit;
  final String category;

  ActionCatalogLoadMore({this.category = '', this.skip = 0, this.limit = 30});
}
