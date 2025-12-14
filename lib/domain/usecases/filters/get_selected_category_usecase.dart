import '../../interfaces/filters_datasource.dart';

class GetSelectedCategoryUseCase {
  final FiltersDataSource _dataSource;

  GetSelectedCategoryUseCase(this._dataSource);

  Future<String> execute() async {
    return await _dataSource.getSelectedCategory();
  }
}

