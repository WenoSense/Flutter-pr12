import '../../interfaces/filters_datasource.dart';

class GetSelectedSortUseCase {
  final FiltersDataSource _dataSource;

  GetSelectedSortUseCase(this._dataSource);

  Future<String> execute() async {
    return await _dataSource.getSelectedSort();
  }
}

