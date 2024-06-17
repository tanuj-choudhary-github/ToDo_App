// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_app/db_services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool personal = true, college = false, office = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream? todoStream;

  void clearText() {
    todoController.clear();
  }

  getonTheLoad() async {
    todoStream = await DatabaseService().getTask(personal
        ? 'Personal'
        : college
            ? 'College'
            : 'Office');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnap = snapshot.data.docs[index];
                        return CheckboxListTile(
                          activeColor: Colors.greenAccent.shade400,
                          title: Text(
                            docSnap["work"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          value: docSnap["Yes"],
                          onChanged: (newValue) async {
                            await DatabaseService().tickMethod(
                                docSnap["Id"],
                                personal
                                    ? 'Personal'
                                    : college
                                        ? 'College'
                                        : 'Office');
                            setState(() {
                              Future.delayed(const Duration(seconds: 2), () {
                                DatabaseService().removeMethod(
                                    docSnap["Id"],
                                    personal
                                        ? 'Personal'
                                        : college
                                            ? 'College'
                                            : 'Office');
                              });
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }),
                )
              : const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 72,
        width: 72,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              openBox();
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.greenAccent.shade400,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white54,
              Colors.white,
              // Colors.cyanAccent,
              // Colors.yellow,
              // Colors.green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   child:  const Text(
            //     'Hii,',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 30,
            //     ),
            //   ),
            // ),
            dummyText(data: 'Hii,', color: Colors.black, textSize: 30),

            dummyText(data: 'Buddy', color: Colors.black, textSize: 47),

            // Container(
            //   child: const Text(
            //     'Buddy',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 50,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 5,
            ),

            dummyText(
                data: 'Let\'s the work begins!',
                color: Colors.black54,
                textSize: 22),

            // Container(
            //   child: const Text(
            //     'Let/s the work begins!',
            //     style: TextStyle(
            //       color: Colors.black54,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                personal
                    ? Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Personal',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = true;
                          college = false;
                          office = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          'Personal',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                college
                    ? Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'College',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = false;
                          college = true;
                          office = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          'College',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                office
                    ? Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Office',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = false;
                          college = false;
                          office = true;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          'Office',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            getWork(),
          ],
        ),
      ),
    );
  }

  Widget dummyText(
      {required String data, required Color color, required double textSize}) {
    return Container(
      child: Text(
        data,
        style: TextStyle(
          color: color,
          fontSize: textSize,
        ),
      ),
    );
  }

  Future openBox() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.cancel,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 100.0,
                    ),
                    Text(
                      "Add ToDo Task",
                      style: TextStyle(
                          color: Colors.greenAccent.shade700, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Add Text',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    controller: todoController,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter the task",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> userTodo = {
                          "work": todoController.text,
                          "Id": id,
                          "Yes": false,
                        };

                        personal
                            ? DatabaseService().addPersonalTask(userTodo, id)
                            : college
                                ? DatabaseService().addCollegeTask(userTodo, id)
                                : DatabaseService().addOfficeTask(userTodo, id);
                        todoController.clear();
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
