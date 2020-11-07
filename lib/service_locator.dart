import 'package:get_it/get_it.dart';
import 'package:schedule/services/localstorage_service.dart';

GetIt locator = GetIt();

Future setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
