import 'package:flutter/material.dart';
import "package:rounded_loading_button/rounded_loading_button.dart";
import 'witze.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Random Jokes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String joke = "";
  Map<String, String> allJokes = {};

  Future<void> getJoke(int index) async {
    String joke = await getRandomJokeCategoryDependent();
    setState(() {
      allJokes.putIfAbsent(index.toString(), () => joke);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Center(
              child: Text("Swipe down to see a joke",
                  style: TextStyle(fontSize: 25)),
            );
          } else {
            if (allJokes.containsKey(index.toString())) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(allJokes[index.toString()] ?? ""),
                ],
              );
            } else {
              getJoke(index);
              return MyRoundedLoadingButton();
            }
          }
        },
      ),
    );
  }
}

class MyRoundedLoadingButton extends StatefulWidget {
  MyRoundedLoadingButton({Key? key}) : super(key: key);

  @override
  _MyRoundedLoadingButtonState createState() => _MyRoundedLoadingButtonState();
}

class _MyRoundedLoadingButtonState extends State<MyRoundedLoadingButton> {
  final RoundedLoadingButtonController roundedLoadingButtonController =
      RoundedLoadingButtonController();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      roundedLoadingButtonController.start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
        controller: roundedLoadingButtonController,
        onPressed: () {},
        child: Text(""),
        animateOnTap: true,
        width: 40);
  }
}

class MyText extends StatelessWidget {
  const MyText(this.text, {Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 23,
        ),
      ),
    );
  }
}
