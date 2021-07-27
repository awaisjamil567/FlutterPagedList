import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paged_list/flutter_paged_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Paged List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key}) : super(key: key);

  var initialData = List<Book>.generate(20, (i) =>
      Book(name: faker.company.name(), description: faker.address.city()));

  var page2 = List<Book>.generate(20, (i) =>
      Book(name: faker.company.name(), description: faker.address.city()));

  Future<List<Book>> getNextPage(int offset) async{
    await Future<List<Book>>.delayed(
      Duration(milliseconds: 5000),
    );
    return page2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: FlutterPagedList<Book>(
        itemList: initialData,
        pageSize: 20,
        itemBuilder: (context, dynamic book) {
          return ListTile(
            title: new Text(book.name),
            subtitle: new Text(book.description),
            leading: Icon(Icons.book),
          );
        },
        onLoading: Container(
          height: 40,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onfetchNextPage:(offset) => getNextPage(offset)
      ),
    );
  }
}

class Book{
  String name;
  String description;
  Book({this.name, this.description = 'Dummy'});
}