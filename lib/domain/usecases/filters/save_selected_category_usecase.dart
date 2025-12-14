import '../../interfaces/filters_datasource.dart';

class SaveSelectedCategoryUseCase {
  final FiltersDataSource _dataSource;

  SaveSelectedCategoryUseCase(this._dataSource);

  Future<void> execute(String category) async {
    return await _dataSource.saveSelectedCategory(category);
  }
}

