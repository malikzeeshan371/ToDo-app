
class ToDo {

  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    this.isDone = false,
    required this.todoText
});
  static List<ToDo> todoList(){
    return[
    ToDo(id: '01', todoText: 'Morning walks', isDone: true),
      ToDo(id: '02', todoText: 'Setting up Bed'),
      ToDo(id: '03', todoText: 'Buy Groceries'),
      ToDo(id: '04', todoText: 'Stand up', isDone: true),
      ToDo(id: '04', todoText: 'Payment Integeration team meeting',),


    ];
  }


}

