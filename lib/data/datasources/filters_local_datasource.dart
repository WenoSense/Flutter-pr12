import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/interfaces/filters_datasource.dart';

class FiltersLocalDataSource implements FiltersDataSource {
  static const String _selectedCategoryKey = 'selected_category';
  static const String _selectedSortKey = 'selected_sort';

  @override
  Future<String> getSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedCategoryKey) ?? 'Все';
  }

  @override
  Future<void> saveSelectedCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCategoryKey, category);
  }

  @override
  Future<String> getSelectedSort() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedSortKey) ?? 'byDate';
  }

  @override
  Future<void> saveSelectedSort(String sortType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedSortKey, sortType);
  }
}

