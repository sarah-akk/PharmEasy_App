import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Auth.dart';
import 'sign.dart';

class MobileAuthScreen extends StatefulWidget {
  static const routeName = '/MobileAuthScreen';

  const MobileAuthScreen({super.key});

  @override
  State<MobileAuthScreen> createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends State<MobileAuthScreen> {

  var _isLoading = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  ///////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String responseMessage = await Provider.of<Auth>(context, listen: false).login(
          _phoneController.text,
          _passwordController.text
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
        else if (responseMessage.startsWith('error'))  {
          _showErrorDialog(responseMessage);
        }
    }
    catch (error) {
      print(error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }
/////////////////////////////////////////////////////////////////////////////////////////
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
///////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: [
                  Container(
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
                                'Please Login to continue..',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 130.0,
                        ),
                        buildTextFieldTxt(
                            txt: 'Phone number',
                            icon: Icon(
                              Icons.phone,
                              color: Colors.deepPurpleAccent,
                            )
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        buildTextFieldPass(
                            txt: 'Password',
                            icon: Icon(Icons.lock_open_outlined, color: Colors.deepPurpleAccent,
                            )),
                        SizedBox(height: 20.0,),


                        Container(
                          width: width,
                          child: ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(child: Divider(indent: 1.0, color: Colors.black38)),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text('OR'),
                              ),
                              Expanded(child: Divider(indent: 1.0, color: Colors.black38)),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Text('Do create your account ?'),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Sign())),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
              ),
            ),


        // Circular Progress Indicator
        Visibility(
          visible: _isLoading,
          child: Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        ],
      ),
    ),
        ),
      )
    );
  }
  TextField buildTextFieldPass({txt, icon}) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          hintStyle: TextStyle(color: Colors.black45), // Set the hint text color her
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
          hintStyle: TextStyle(color: Colors.black45), // Set the hint text color her
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.blue.shade300))),

    );
  }
}
