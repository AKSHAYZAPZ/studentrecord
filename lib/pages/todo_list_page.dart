// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TodoListPage extends StatelessWidget {
//   TodoListPage({Key? key}) : super(key: key);

//   final _textController = TextEditingController();
//   final _textEditController =TextEditingController();

//   get editId => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text('Todo List'),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10))),
//                         hintText: 'Type here',
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       addTask();
//                     },
//                     child: const Text('Add Task'),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('mytodolist')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const CircularProgressIndicator();
//                     } else {
//                       return ListView(
//                         children: snapshot.data!.docs.map((document) {
//                           return Dismissible(
//                               background: Container(
//                                 color: Colors.red,
//                                 child: const Icon(Icons.delete),
//                               ),
//                               key: Key(document.id),
//                               onDismissed: (direction) {
//                                 onDelete(document.id);
//                               },
//                               child: ListTile(
//                                 trailing: IconButton(
//                                     onPressed: () {
//                                       showModalBottomSheet(
//                                         context: context,
//                                         builder: (ctx) {
//                                           return Column(
//                                             children: [
//                                                Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: TextField(
//                                                   controller: _textEditController,
//                                                   decoration: const InputDecoration(
//                                                     border: OutlineInputBorder()
//                                                   ),
//                                                 ),
//                                               ),
//                                               ElevatedButton(onPressed: () {
//                                                 editTask(document.id);
//                                                 Navigator.of(ctx).pop();
//                                               }, child: const Text('Update'))
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                     icon: const Icon(Icons.edit)),
//                                 title: Text(document['title']),
//                               ));
//                         }).toList(),
//                       );
//                     }
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void addTask() {
//     FirebaseFirestore.instance
//         .collection('mytodolist')
//         .add({'title': _textController.text});
//         _textController.text = '';
//   }

//   void onDelete(String id) {
//     FirebaseFirestore.instance.collection('mytodolist').doc(id).delete();
//   }

//   void editTask(String id) {
//     FirebaseFirestore.instance
//         .collection('mytodolist')
//         .doc(id)
//         .update({'title': _textEditController.text});
//         _textEditController.text= '';
//   }
// }
