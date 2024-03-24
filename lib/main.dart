import 'package:api/datamodel.dart';
import 'package:api/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomScreen(),
      ),
    );
  }
}

class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getdata();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<ApiProvider>(
          builder: (BuildContext context, provider, _) {
            if (provider.usersData.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: provider.usersData.length,
                  itemBuilder: (context, index) {
                    DataModel data = provider.usersData[index];
                    print(data);
                    return ListTile(
                      title: Text("${data.first_name} ${data.last_name}"),
                      subtitle: Text("${data.email} ${data.id}"),
                      leading: CircleAvatar(child: Image.network(data.avatar)),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
