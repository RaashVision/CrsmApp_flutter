
import 'package:ESmile/interfaces/i_camera.dart';
import 'package:ESmile/interfaces/i_datetimeutil.dart';
import 'package:ESmile/repository/api/dio/dio_api.dart';
import 'package:ESmile/repository/local_db/sembast_nosql/estodo_dao.dart';
import 'package:ESmile/services/dialog_service.dart';
import 'package:ESmile/services/imagepicker_camera_service.dart';
import 'package:ESmile/services/navigation_service.dart';
import 'package:ESmile/services/permission_service.dart';
import 'package:ESmile/services/rabbitmq_service.dart';
import 'package:ESmile/utils/converter_utils.dart';
import 'package:ESmile/utils/network_error_utils.dart';
import 'package:ESmile/utils/validator_utils.dart';
import 'package:ESmile/viewmodels/cr_home_viewmodel.dart';
import 'package:ESmile/viewmodels/es_addupdatetodo_viewmodel.dart';
import 'package:ESmile/viewmodels/es_timeleft_viewmodel.dart';
import 'package:ESmile/viewmodels/rv_chatmessage_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ESmile/interfaces/i_vibration.dart';
import 'package:ESmile/repository/repository.dart';
import 'package:ESmile/services/vibration_services.dart';
import 'package:ESmile/utils/datetime_utils.dart';
import 'interfaces/i_api.dart';
import 'interfaces/i_localdatabase.dart';
import 'interfaces/i_messagebroker.dart';
import 'interfaces/i_repository.dart';
import 'interfaces/i_validator.dart';
import 'managers/stream_manager.dart';
import 'viewmodels/es_home_viewmodel.dart';
import 'viewmodels/es_todo_viewmodel.dart';
import 'viewmodels/rv_chat_viewmodel.dart';

GetIt locator = GetIt.I;

void setupLocator() {
//This file is for dependecies injection

locator.registerSingleton(()=> Dio());

 locator.registerSingleton(new DateTimeUtils());
 locator.registerLazySingleton<IVibration>(()=> new VibrationServices());
 locator.registerLazySingleton(()=>ConverterHelperUtils());
// locator.registerSingleton(new Services());



 locator.registerLazySingleton(() => NavigationService());
locator.registerFactory(() =>ESTodoViewModel());
locator.registerFactory(() =>ESHomeViewModel());
locator.registerFactory(() =>ESAddUpdateTodoViewModel());
locator.registerFactory(()=>ESTimeLeftViewModel());
locator.registerFactory(()=>RVChatViewModel());
locator.registerFactory(()=>RVChatMessageViewModel());

locator.registerFactory(()=>CRHomeViewModel());


locator.registerLazySingleton<ILocalDatabase>(()=> new SembastTodoDAO());
locator.registerLazySingleton<IValidator>(()=> new ValidatorUtils());
locator.registerLazySingleton<IDateTimeUtils>(()=> new DateTimeUtils());
locator.registerLazySingleton(()=>StreamManager());
locator.registerLazySingleton(() => DialogService());
locator.registerLazySingleton<IMessageBroker>(()=> new RabbitMQService());
locator.registerLazySingleton(()=> PermissionService());
locator.registerLazySingleton<ICameraService>(()=>ImagePickerCameraService(null,null));


locator.registerLazySingleton<IApi>(()=>DioAPI(null));
locator.registerLazySingleton(()=>NetworkErrorHandlerUtils());
 locator.registerLazySingleton<IRepository>(()=> new Repository(null,null,null));
  
}

