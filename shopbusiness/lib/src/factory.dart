import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'factory.config.dart';

import 'package:shopdata/shopdata.dart';

@InjectableInit()
void factoryInit() {
  serviceProviderInit();
  GetIt.I.init();
}
