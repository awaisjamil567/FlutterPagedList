# flutter_pagged_list

A new Flutter Package for handling pagination. It allows to display items in list with default pagination feature.

## Getting Started

Library: 

flutter_paged_list: 0.0.1

Code:

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

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
