import 'package:flutter/material.dart';
import 'package:quizapp/animals.dart';
import 'package:quizapp/books.dart';
import 'package:quizapp/cartoonandanimation.dart';
import 'package:quizapp/gadgets.dart';
import 'package:quizapp/history.dart';
import 'package:quizapp/mythology.dart';
import 'package:quizapp/scienceandnature.dart';
import 'package:quizapp/sports.dart';
import 'package:quizapp/vehicles.dart';
import 'package:quizapp/videogames.dart';
import 'computerquiz.dart';
import 'generalknowledge.dart';
import 'geography.dart';
import 'mathquiz.dart';
import 'quiz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The Quiz App",
      theme: new ThemeData.light(),
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Quiz quiz;
  List<Results> results;

  Future<void> fetchQuestions() async {
    var res = await http.get("https://opentdb.com/api.php?amount=50");
    var decRes = jsonDecode(res.body);
    quiz = Quiz.fromJson(decRes);
    results = quiz.results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 20.0,
        title: new Text(
          "The Quiz App",
          style: new TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchQuestions,
        child: FutureBuilder(
            future: fetchQuestions(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return errorData(snapshot);
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ));
                case ConnectionState.done:
                  if (snapshot.hasError) return errorData(snapshot);
                  return questionList();
              }
            }),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(
                "I love anything quiz related!",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              accountName: Text(
                "The Quiz App",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: new CircleAvatar(
                radius: 20.0,
                backgroundImage: new AssetImage("images/quiz.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new ListTile(
                leading: new Icon(Icons.category),
                title: Text(
                  "All Categories",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.computer),
                title: Text(
                  "Computers",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.looks_6),
                title: Text(
                  "Maths",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MathPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.web),
                title: Text(
                  "General Knowledge",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => GPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.wb_iridescent),
                title: Text(
                  "Science & Nature",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SNPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.book),
                title: Text(
                  "Mythology",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.accessibility_new),
                title: Text(
                  "Sports",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SPPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.toys),
                title: Text(
                  "Geography",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => GEOPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.border_all),
                title: Text(
                  "Books",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.directions_car),
                title: Text(
                  "Vehicles",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => VPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.phone_android),
                title: Text(
                  "Gadgets",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => GDPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.adb),
                title: Text(
                  "Cartoon & Animations",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    // Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CAPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.looks),
                title: Text(
                  "Video Games",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => VGPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.pets),
                title: Text(
                  "Animals",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ANPage()));
                  });
                },
              ),
            ),
            new Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.view_comfy),
                title: Text(
                  "History",
                  style: styleText(),
                ),
                onTap: () {
                  setState(() {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HPage()));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView questionList() {
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 20.0,
            child: ExpansionTile(
                initiallyExpanded: true,
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[50],
                  child: Text(
                    results[index].type.startsWith("m") ? "M" : "B",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                children: results[index].allAnswers.map((m) {
                  return AnswerWidget(results, index, m);
                }).toList(),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        results[index]
                            .question
                            .replaceAll('&quot;', '\"')
                            .replaceAll('&pi;', 'π')
                            .replaceAll('&#039;', '\'')
                            .replaceAll('&amp;', '&')
                            .replaceAll('&lt;', '<')
                            .replaceAll('&gt;', '>')
                            .replaceAll('&eacute;', 'e')
                            .replaceAll('&rsquo', '\''),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      new FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FilterChip(
                              backgroundColor: Colors.grey[100],
                              label: Text(
                                results[index].category,
                                style: TextStyle(color: Colors.black),
                              ),
                              onSelected: (v) {},
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            FilterChip(
                              backgroundColor: Colors.grey[100],
                              label: Text(
                                results[index].difficulty,
                                style: TextStyle(color: Colors.black),
                              ),
                              onSelected: (v) {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Check Your Internet Connection!",
              style: styleText(),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text(
                "Try Again",
              ),
              onPressed: () {
                fetchQuestions();
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}

class AnswerWidget extends StatefulWidget {
  final List<Results> results;
  final int index;
  final String m;

  AnswerWidget(this.results, this.index, this.m);

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  Color c;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.m
            .replaceAll('&quot;', '\"')
            .replaceAll('&pi;', 'π')
            .replaceAll('&#039;', '\'')
            .replaceAll('&amp;', '&')
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&eacute;', 'e')
            .replaceAll('&rsquo', '\''),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        setState(() {
          if (widget.m == widget.results[widget.index].correctAnswer) {
            c = Colors.green;
          } else {
            c = Colors.redAccent;
          }
        });
      },
    );
  }
}

TextStyle styleText() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
  );
}
