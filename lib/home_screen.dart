import 'package:flutter/material.dart';

import 'contact_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _nameTEcontroller = TextEditingController();
  final _mobileTEcontroller = TextEditingController();
  List<Contact> contacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(
          child: Text(
            'Contact List',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ) ,
        backgroundColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30), // Adjust if you want rounded corners
            bottom: Radius.circular(0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: _nameTEcontroller,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2,
                    )
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: _mobileTEcontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Enter Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        )
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: _addContact,
                  style: ElevatedButton.styleFrom(
                    padding:const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))
                  ),
                  child: const Center(child: Text('Add'))),
            ),
            const SizedBox(height: 12,),
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  contacts.length,
                      (index) => InkWell(
                    onLongPress: () {
                      _showDeleteConfirmationDialog(index);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading:const Icon(Icons.account_box,size: 50,),
                          title: Text(contacts[index].name,style:const TextStyle(color: Colors.red,fontSize: 20),),
                          subtitle: Text(contacts[index].phoneNumber),
                          trailing:const Icon(Icons.call,color: Colors.blueAccent,size: 25,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Confirmation'),
          content:const Text('Are you sure for delete?'),
          actions:[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.delete_forever,size: 30,),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.removeAt(index);
                });
                Navigator.pop(context);
              },
              child:const Icon(Icons.delete_outline_rounded,size: 30,),
            ),
          ],
        );
      },
    );
  }

  void _addContact() {
    String name = _nameTEcontroller.text;
    String mobile = _mobileTEcontroller.text;
    setState(() {
      contacts.add(Contact(name: name, phoneNumber: mobile));
    });
    _nameTEcontroller.clear();
    _mobileTEcontroller.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileTEcontroller.dispose();
    _nameTEcontroller.dispose();
  }
}
