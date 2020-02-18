import 'package:ESmile/interfaces/i_vibration.dart';
import 'package:vibration/vibration.dart';

class VibrationServices implements IVibration {



  @override
  void vibrateForDurationInMilisecond(int seconds) {
    
    Vibration.vibrate(duration: seconds);
  }





}