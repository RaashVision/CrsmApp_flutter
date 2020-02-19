
import 'package:CrResposiveApp/interfaces/i_datetimeutil.dart';
import 'package:CrResposiveApp/repository/api/dio/dio_api.dart';
import 'package:CrResposiveApp/services/dialog_service.dart';
import 'package:CrResposiveApp/services/navigation_service.dart';
import 'package:CrResposiveApp/services/permission_service.dart';
import 'package:CrResposiveApp/utils/converter_utils.dart';
import 'package:CrResposiveApp/utils/network_error_utils.dart';
import 'package:CrResposiveApp/viewmodels/cr_detail_viewmodel.dart';
import 'package:CrResposiveApp/viewmodels/cr_home_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:CrResposiveApp/repository/repository.dart';
import 'interfaces/i_api.dart';
import 'interfaces/i_repository.dart';
import 'managers/stream_manager.dart';

GetIt locator = GetIt.I;

void setupLocator() {
//This file is for dependecies injection

locator.registerSingleton(()=> Dio());
locator.registerLazySingleton(()=>ConverterHelperUtils());
locator.registerLazySingleton(() => NavigationService());
locator.registerFactory(()=>CRHomeViewModel());
locator.registerFactory(()=>CRDetailViewModel());
locator.registerLazySingleton(()=>StreamManager());
locator.registerLazySingleton(() => DialogService());
locator.registerLazySingleton(()=> PermissionService());
locator.registerLazySingleton<IApi>(()=>DioAPI(null));
locator.registerLazySingleton(()=>NetworkErrorHandlerUtils());
 locator.registerLazySingleton<IRepository>(()=> new Repository());
  
}

