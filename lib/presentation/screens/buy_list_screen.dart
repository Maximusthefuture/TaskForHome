import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/data/local_data_source.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/data/remote_data_source.dart';
import 'package:tasks_for_home/data/todo_data_source.dart';
import 'package:tasks_for_home/data/todo_list_repository_impl.dart';
import 'package:tasks_for_home/db/buy_list_dao.dart';
import 'package:tasks_for_home/widgets/buy_list_bottom_sheet.dart';
import 'package:tasks_for_home/widgets/buy_list_cell.dart';

enum Some { showRemote, showLocal, deleteAllLocal, deleteAllRemote, showAll }

class BuyListScreen extends StatefulWidget {
  BuyListScreen({Key? key}) : super(key: key);

  @override
  _BuyListScreenState createState() => _BuyListScreenState();
}

class _BuyListScreenState extends State<BuyListScreen> {
  //TODO: need personal list?
  RemoteDataSouce remoteDataSource = RemoteDataSouce();
  LocalDataSource localDataSource = LocalDataSource();
  Some? some = Some.showRemote;
  List<BuyList> buyList = [];
  StreamSubscription<QuerySnapshot>? _streamSubscription;
  TodoListRepositoryImpl? repository;

  void _updateWatchList(QuerySnapshot snapshot) {
    setState(() {
      buyList = repository!.getItemFromQuery(snapshot);
      // g();
    });
  }

  _BuyListScreenState() {
    // if (!showCheckedItems) {

    repository = TodoListRepositoryImpl(
        remoteDataSource: remoteDataSource, localDataSource: localDataSource);
    switch (some) {
      case Some.showAll:
        print("Show All");
        break;
      case Some.showRemote:
        print("Show remote");
        break;
      case Some.showLocal:
        print("show local");
        break;
      case Some.deleteAllLocal:
        print("Delete All Lolcals");
        break;
      case Some.deleteAllRemote:
        print("Delete All Remote");
        break;
        case null: print("null");
    }
    _streamSubscription =
        repository!.getAllTodoItems().listen(_updateWatchList);
    // g();
    // } else {
    // _streamSubscription = repository.getDoneItems().listen(_updateWatchList);
    // }
  }

  void g() async {
    buyList = await localDataSource.getAllItems();
  }

  var local = true;
  bool showToAll = true;
  
  BuyList? buyListModel;
  bool showCheckedItems = false;
  
  final myController = TextEditingController();
  FocusNode? focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
    focusNode?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    bool? isSelected = false;
    var provider = Provider.of<LoginState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.add),
            onPressed: () {
              showAddItemMenu(context, myController, provider);
            },
          ),
          PopupMenuButton(
              onSelected: (result) {
                switch (result) {
                  case Some.showLocal:
                    isSelected = true;
                    print("show local");
                    break;
                  case Some.showRemote:
                    isSelected = false;
                    print("show remote");
                    break;
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<Some>>[
                    PopupMenuItem<Some>(
                      value: Some.showLocal,
                      child: Text("Show local"),
                    ),
                    PopupMenuItem<Some>(
                      value: Some.showRemote,
                      child: Text("Show remote"),
                    ),
                    // const PopupMenuDivider(),
                    // PopupMenuItem<Some>(
                    //   value: Some.showLocal,
                    //   child: ListTile(
                    //       leading: Icon(null), title: Text('Bring hurricane')),
                    // ),
                  ])
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: buyList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = buyList[index];
              if (item.isChecked == 0) {
                return Dismissible(
                    key: Key("f"),
                    onDismissed: (direction) {
                      setState(() {
                        buyList.removeAt(index);
                        item.isChecked = 1;
                        provider.updateTodoData(
                            item.reference!.id, item.isChecked!);
                        TodoListDB.db.removeItem(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Deleted"),
                      ));
                    },
                    background: Container(color: Colors.red),
                    child: BuyListCell(item));
              } else if (item.isChecked == 0 && showCheckedItems) {
                return BuyListCell(item);
              }
              return Container();
              // return Container();
            }),
      ),
    );
  }

  

  void showAddItemMenu(BuildContext context, TextEditingController myController,
      LoginState appState) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            // return Padding(
            // padding: MediaQuery.of(context).viewInsets,
            // return modalBottomShit(context, myController, appState);
            return BuyListAddMenuBottomSheet(myController: myController, 
            appState: appState, 
            buyListModel: buyListModel, repository: repository,);
          });
        });
  }
}
