// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:recan/http/httpProductComment.dart';

class ProductCommentSection extends StatefulWidget {
  const ProductCommentSection({Key? key}) : super(key: key);

  @override
  _ProductCommentSectionState createState() => _ProductCommentSectionState();
}

class _ProductCommentSectionState extends State<ProductCommentSection> {
  String comment = '';
  final formkey = GlobalKey<FormState>();
  //
  Future<bool> commentPost(String comment , String productid) async {
    var res = HttpProductcomment().comment(comment , productid);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            "Comment Section",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Form(
            key:formkey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: TextFormField(
                onSaved: (val) {
                  comment = val!;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Empty comment cannot post';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Comment here", border: OutlineInputBorder()),
              ),
            ),
          ),
          //  Button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton(
                  onPressed: ()async {
                    if(formkey.currentState!.validate()){
                      formkey.currentState!.save();

                       var res = await commentPost(comment , '620bb8231ae312c23c58a08b');
                       if(res){
                         MotionToast.success(
                                        description: const Text("Comment Post"))
                                    .show(context);
                       }else{
                         MotionToast.error(
                                        description: const Text("Something went wrong"))
                                    .show(context);
                       }
                    }
                  }, child: const Icon(MdiIcons.comment)),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "All comments",
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Show comments
          Container(
            constraints: const BoxConstraints(maxHeight: double.infinity),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/samishan.jpg'),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'The input method toggled cursor monitoring on',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/samishan.jpg'),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'The input method toggled cursor monitoring on',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/samishan.jpg'),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'The input method toggled cursor monitoring on',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
