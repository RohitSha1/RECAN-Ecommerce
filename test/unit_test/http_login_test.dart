import 'package:flutter_test/flutter_test.dart';
import 'package:recan/http/httpuser.dart';

void main(){
  final HttpUser httpConn =  HttpUser();
  test('login' ,()async{
    var responce =  await httpConn.loginUser('dflutter@gmail.com' , '134567i');
      expect(responce , false);
  });
  
}