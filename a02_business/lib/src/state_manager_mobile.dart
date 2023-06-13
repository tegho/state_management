import 'package:injectable/injectable.dart';

import 'package:datamodels/datamodels.dart';
import 'package:shopdata/shopdata.dart';

@injectable
class StateManagerMobile {
  final DataService _dataService;

  StateManagerMobile(this._dataService);

  Future<DataResponse> prod({required int id}) async {
    return await _dataService.getProduct(id: id);
  }
  // Future<int> distance() async {
  //   final res = await Future.wait([
  //     dataService.getMyLocation(),
  //     dataService.getHisLocation(),
  //   ]);
  //
  //   return (res[0].position - res[1].position).abs();
  // }
}
