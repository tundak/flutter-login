import 'package:flutter/material.dart';
import 'package:flutter_demo/model/user.dart';
import 'package:flutter_demo/screens/home/home_screen_presenter.dart';
import 'package:flutter_demo/data/database_helper.dart';
import 'package:flutter_demo/screens/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> implements HomeScreenContract {

  HomeScreenPresenter _presenter;
  String _homeText;

  HomeScreenState() {
    _presenter = new HomeScreenPresenter(this);
    _presenter.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {  
    return new Scaffold(
      appBar: new AppBar(title: new Text("Home"),actions: <Widget>[LogoutButton()],),
      body: new Center(
        child: new Text(_homeText),
      ),
    );
  }

  @override
  void onDisplayUserInfo(User user) {
    setState(() {
      _homeText = 'Hello ${user.username}';
    });
  }

  @override
  void onErrorUserInfo() {
    setState(() {
      _homeText = 'There was an error retrieving user info';
    });
  }

}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(Icons.exit_to_app),
        onPressed: () async {
          print("logout");
          //await AuthService().logout();
          var db = new DatabaseHelper();
          await db.deleteUsers();

          Navigator.pushReplacementNamed(context, "/");

//          Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//              settings: RouteSettings(name: "LoginPage"),
//              builder: (BuildContext context) => LoginScreen()),
//          );
        });
  }
}