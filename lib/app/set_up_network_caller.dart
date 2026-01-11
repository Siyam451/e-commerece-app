import 'package:ecommerce_project/app/core/services/network_api_caller.dart';

NetworkCaller getNetworkcaller(){
  NetworkCaller networkCaller = NetworkCaller(
      headers: {
        'Content-type': 'application/json',
        // 'token': 'token',
      },
      onUnauthorize: (){
        //move to login
      }
      );

  return networkCaller;

}