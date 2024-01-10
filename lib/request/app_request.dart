import 'package:dio/dio.dart';
import 'package:wowowwish/config/data_config.dart';

class AppRequestType {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://114.116.111.148:8300',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 10),
  ));
  Dio getDio() {
    return _dio;
  }

  Dio getDioWithToken(token) {
    _dio.options.headers = {"token": token};//返回头部的网络标识
    return _dio;
  }
  final _dioCodeGet = Dio(//拿后台数据
    BaseOptions(
      baseUrl: 'https://uni.apistd.com',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 10),
        headers:{
          "Content-Type":'application/json'
        },
      queryParameters: {
        'action':'sms.message.send',
        'accessKeyId': ConfigEncryption.decryptConfig()['accessIdKey']
      }
    )
  );

  Dio getDioCodeGet(){
    return _dioCodeGet;
  }
}
