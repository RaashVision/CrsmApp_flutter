
import 'package:ESmile/models/service_result.dart';

abstract class ICameraService
{
    //Future<File> getImageFromCameraFile();

    Future<ServiceResultAndStatus> getImageFromCameraByte();
}