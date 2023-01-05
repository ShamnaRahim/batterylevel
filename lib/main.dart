import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    home: GetBatteryLevel(),
    );
  }
}

class GetBatteryLevel extends StatefulWidget {
  const GetBatteryLevel({Key? key}) : super(key: key);

  @override
  State<GetBatteryLevel> createState() => _GetBatteryLevelState();
}

class _GetBatteryLevelState extends State<GetBatteryLevel> {

  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batrylevel = 'unknown battery level';

 Future<void> getBatteryLevel()async{
     String batterylevel;
     try{
      final int result = await platform.invokeMethod('getBatteryLevel');
       batterylevel = 'battery level at $result% ';
     } 
     on PlatformException catch(e) {
          batterylevel = 'failed to get batterylevel ${e.code}';
          
     }

     setState(() {
       _batrylevel = batterylevel;
     });
 }
  @override
  Widget build(BuildContext context) {
    return Material(
      
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: getBatteryLevel, child: Text('get btry level')),
            Text(_batrylevel)
          ],
        ),
      ),
    );
  }
}
