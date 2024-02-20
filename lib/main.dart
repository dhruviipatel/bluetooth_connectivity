import 'package:blutooth_connectivity/controllers/blutoothController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blutooth Connectivity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blutooth'),
        ),
        body: GetBuilder<BlutoothController>(
          init: BlutoothController(),
          builder: (controller) {
            return Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.scanDevice();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "Scan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
                  StreamBuilder(
                      stream: controller.scanResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print("error in snapshot");
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(snapshot.data![index].device.name
                                      .toString()),
                                );
                              });
                        }
                        return Container(
                          child: Text('No device '),
                        );
                      })
                ],
              ),
            );
          },
        ));
  }
}
