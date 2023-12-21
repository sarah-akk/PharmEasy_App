import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';

class Sign extends StatefulWidget {

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  var _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  //////////////////////////////////////////////////////////////////////////////////////
  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String responseMessage = await Provider.of<Auth>(context, listen: false)
          .signUp(
        _nameController.text,
        _phoneController.text,
        _passwordController.text,
        _passwordConfirmController.text,
      );
      if (responseMessage.startsWith('success')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseMessage),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
        Navigator.of(context).pushNamed('/MobileOverviewScreen');
      }
      
      else if (responseMessage.startsWith('error')) {
        _showErrorDialog(responseMessage);
      }
    }
    catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      print(error.toString());
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }
  ////////////////////////////////////////////////////////////////////////////////////////////
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
  //////////////////////////////////////////////////////////////////////////////////////////
  @override

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100.0,
                              ),
                              Text(
                                'Welcome',
                                style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Create Sign to continue..',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 130.0,
                        ),
                        buildTextFieldname(
                            txt: 'name',
                            icon: Icon(Icons.lock_open_outlined, color: Colors.deepPurpleAccent,
                            )),
                        buildTextFieldTxt(
                            txt: 'Phone number',
                            icon: Icon(
                              Icons.email_outlined,
                              color: Colors.deepPurpleAccent,
                            )),
                        SizedBox(
                          height: 10.0,
                        ),

                        buildTextFieldPass(
                            txt: 'Password',
                            icon: Icon(Icons.lock_open_outlined, color: Colors.deepPurpleAccent,
                            )),
                        SizedBox(height: 10.0,),
                        buildTextFieldconfPass(
                            txt: 'Conf Password',
                            icon: Icon(Icons.lock_open_outlined, color: Colors.deepPurpleAccent,
                            )),
                        SizedBox(height: 10.0,),

                        Container(
                          width: width,
                          child: ElevatedButton(
                            onPressed: (){
                              _submit();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40.0)
                                    )
                                )
                            ),
                            child:Text('Sign Up'),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15.0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap:()=>Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.keyboard_backspace,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          Text(
                            'Back to login',
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        width: width,
                        height: 1.0,
                        color: Colors.blue.shade200,
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  TextField buildTextFieldPass({txt, icon}) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          suffixIcon: Icon(Icons.remove_red_eye_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.blue.shade300))),
    );
  }

  TextField buildTextFieldTxt({txt, icon}) {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.blue.shade300))),
    );
  }

TextField buildTextFieldname({txt, icon}) {
  return TextField(
    controller: _nameController,
    decoration: InputDecoration(
        prefixIcon: icon,
        hintText: txt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
            borderSide: BorderSide(color: Colors.blue.shade300))),
  );
}
  TextField buildTextFieldconfPass({txt, icon}) {
    return TextField(
      controller: _passwordConfirmController,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.blue.shade300))),
    );
  }
}




