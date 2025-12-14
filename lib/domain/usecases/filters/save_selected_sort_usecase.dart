import '../../interfaces/filters_datasource.dart';

class SaveSelectedSortUseCase {
  final FiltersDataSource _dataSource;

  SaveSelectedSortUseCase(this._dataSource);

  Future<void> execute(String sortType) async {
    return await _dataSource.saveSelectedSort(sortType);
  }
}

