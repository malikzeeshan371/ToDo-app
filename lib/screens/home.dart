import 'package:flutter/material.dart';
import 'package:i_food/constants/colors.dart';
import 'package:i_food/model/todo.dart';
import 'package:i_food/widgets/todo_item.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //const Home({Key? key}) : super(key: key);
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(child: Image.asset('assets/images/img2.png'),
                borderRadius: BorderRadius.circular(20),),
            )
          ],
        ),
      ),
      body: Stack(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20),
                            child: Text('All ToDos', style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),),
                          ),
                          for(ToDo todo in _foundToDo)
                            ToDoItem(
                              todo: todo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteTodoItem,

                            ),


                        ],
                      ),
                    )

                  ],
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 20, right: 20, left: 20),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.0
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                              hintText: 'Add a new Todo item',
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        child: Text('+', style: TextStyle(fontSize: 40),),
                        onPressed: () {
                          _addTodoItem(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10,
                        ),
                      ),
                    )
                  ]
              ),
            )
          ]
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword) {
    List<ToDo> results = [];
    if (enterKeyword.isEmpty) {
      results = todoList;
    }
    else {
      results = todoList.where((item) =>
          item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }


  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
                maxWidth: 25
            ),
            border: InputBorder.none,
            hintText: 'Search'
        ),
      ),
    );
  }
}


