import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

final CollectionReference _studentlist =
    FirebaseFirestore.instance.collection('studentlist');

class _HomepageState extends State<Homepage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _fatherController = TextEditingController();
  final _numberController = TextEditingController();

  final _fathercreateController = TextEditingController();
  final _numbercreateController = TextEditingController();
  final _namecreateController = TextEditingController();
  final _agecreateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Student name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: _namecreateController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: _agecreateController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Father name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: _fathercreateController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Contact number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: _numbercreateController,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String _name = _namecreateController.text;
                  final num? _age =
                      num.tryParse(_agecreateController.text);
                  final String _fathername = _fathercreateController.text;
                  final num? _mob =
                      num.tryParse(_numbercreateController.text);

                  await _studentlist.add({
                    'name': _name,
                    'age': _age,
                    'fathername': _fathername,
                    'phone': _mob
                  });
                  _namecreateController.text = '';
                  _agecreateController.text = '';
                  _fathercreateController.text = '';
                  _numbercreateController.text = '';
                },
                child: const Text('Create'),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _studentlist.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentsnap =
                              streamSnapshot.data!.docs[index];
                          return Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            key: Key(documentsnap.id),
                            onDismissed: (direction) async {
                              await _studentlist.doc(documentsnap.id).delete();
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                key: Key(documentsnap.id),
                                title: Row(
                                  children: [
                                    const Text(
                                      "Name: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("${documentsnap['name']}"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Age: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text("${documentsnap['age']}"
                                            .toString()),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Father name: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text("${documentsnap['fathername']}"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Phone: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text("${documentsnap['phone']}"
                                            .toString())
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () async {
                                      await textPlace(documentsnap);
                                      bottomSheetcall(documentsnap.id);
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (!streamSnapshot.hasData) {
                      return Container();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheetcall(id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Productname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              controller: _nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              controller: _ageController,
            ),
            const SizedBox(
              height: 10,
            ),TextField(
                decoration: const InputDecoration(
                  hintText: 'Father name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: _fatherController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Contact number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                controller: _numberController,
              ),
            ElevatedButton(
                onPressed: () async {
                  final String _name = _nameController.text;
                  final num? _age = num.tryParse(_ageController.text);
                  final String _fathername = _fathercreateController.text;
                  final num? _mob =
                      num.tryParse(_numbercreateController.text);
                  if (_age != null) {
                    await _studentlist.doc(id).update({
                      'name': _name,
                      'age': _age,
                      'fathername': _fathername,
                      'phone': _mob
                    });
                    _nameController.text = '';
                    _ageController.text = '';
                    _fatherController.text = '';
                    _numberController.text = '';

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }

  Future<void> textPlace([DocumentSnapshot? documentsnap]) async {
    if (documentsnap != null) {
      _nameController.text = documentsnap['name'];
      _ageController.text = documentsnap['age'].toString();
      _fatherController.text = documentsnap['fathername'];
      _numberController.text = documentsnap['phone'].toString();
    }
  }

}
