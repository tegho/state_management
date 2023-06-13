import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'business_provider.config.dart';
import 'package:shopdata/shopdata.dart';

@InjectableInit()
void businessProviderInit() {
  serviceProviderInit();
  GetIt.I.init();
}
