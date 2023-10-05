
import 'package:flutter_test/flutter_test.dart';
import 'package:recan/http/httpuser.dart';

void main(){
  final HttpUser httpConn =  HttpUser();

  test('register' ,()async{
    var responce =  await httpConn.registerUser('flutter', 'deflutter@gmail.com', '123445789');
      expect(responce , false);
  });
}