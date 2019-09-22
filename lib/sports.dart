import 'package:flutter/material.dart';
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
      theme: new ThemeData(primaryColor: Colors.white),
      home: new SPPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SPPage extends StatefulWidget {
  @override
  _SPState createState() => _SPState();
}

class _SPState extends State<SPPage> {
  Quiz quiz;
  List<Results> results;

  Future<void> fetchQuestions() async {
    var res =
    await http.get("https://opentdb.com/api.php?amount=50&category=21");
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
          "Sports Quiz",
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
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 5.0,
                      ));
                case ConnectionState.done:
                  if (snapshot.hasError) return errorData(snapshot);
                  return questionList();
              }
            }),
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
                            .replaceAll('&#039;', '\'')
                            .replaceAll('&amp;', '&')
                            .replaceAll('&lt;', '<')
                            .replaceAll('&gt;', '>'),
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
        widget.m.replaceAll('&quot;', '\"')
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
