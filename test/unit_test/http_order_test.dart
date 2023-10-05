import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recan/http/productOrder.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final Httporder httpConn =  Httporder();

String? orderid = '62e7b614fa1f66668b257aeb';
  test('order Test' ,()async{
     var res= await httpConn.order(orderid);
      expect(res , true);
  });
}