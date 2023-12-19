import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'Screens/login.dart';

class StartPage extends StatefulWidget {
  static const routeName = '/StartPage';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstPage(),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page.toDouble();
              });
            },
            children: [
              Container(
                width: 300,
                height: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child:  Image.asset(
                        'assets/images/Screenshot 2023-12-15 151652.jpg',
                        fit: BoxFit.fill,
                        width: 300,
                        height: 300,
                      ),
                    ) ,
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //ClipOval
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/Screenshot 2023-12-15 151734.jpg',
                        fit: BoxFit.cover,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DotsIndicator(
          dotsCount: 2,
          position: _currentPage,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamed(MobileAuthScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(100, 50),
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    )
                )
            ),
            child:Text('start !', style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}



