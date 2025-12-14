abstract class FiltersDataSource {
  Future<String> getSelectedCategory();
  
  Future<void> saveSelectedCategory(String category);
  
  Future<String> getSelectedSort();
  
  Future<void> saveSelectedSort(String sortType);
}

