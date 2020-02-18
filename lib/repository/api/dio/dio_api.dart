import 'dart:convert';

import 'package:ESmile/api_urls.dart';
import 'package:ESmile/enums/viewstate.dart';
import 'package:ESmile/interfaces/i_api.dart';
import 'package:ESmile/locator.dart';
import 'package:ESmile/models/result.dart';
import 'package:ESmile/models/typicode_photo.dart';
import 'package:ESmile/utils/network_error_utils.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as kokoi;
class DioAPI implements IApi{


  Response response;
  Dio dio ;
  NetworkErrorHandlerUtils _errorHandlerUtils = locator<NetworkErrorHandlerUtils>();
  //Constructor
  DioAPI(Dio _dio){

    dio = _dio??new Dio();
    //dio.options.connectTimeout =60*1000; 
    dio.options.receiveTimeout =60*1000; 
    dio.options.sendTimeout = 60*1000;

  }



  @override
  Future<ResultAndStatus> gettypicodephotosbyId(int albumId) async {

    try{

      String errormessage = null;

      response = await dio.get(TypiCodeAPIUrls.typicodemainurl+TypiCodeAPIUrls.typicodephotourl+"?albumId="+albumId.toString());

       if(response.data != null){
        
        //Decode the json
         //var responceJson = jsonDecode(response.data);

        //Deseriliaze to object
         var asList = (response.data as List)
                .map((p) => TypiCodePhoto.fromJson(p))
                .toList();


          return ResultAndStatus(ViewState.Idle,errormessage,asList);


       }            


    }
    //If response is not success
    on DioError catch(e) {

      return _errorHandlerUtils.properErrorMessageDioResponce(response);

    }

  }




}