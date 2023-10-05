// import 'package:blog_app/http/httpComment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recan/http/httpProductComment.dart';

void main(){
  final HttpProductcomment httpConn =  HttpProductcomment();

  test('Comment' ,()async{
      httpConn.comment('Rohitsah', 'rohit1235');
  });
}