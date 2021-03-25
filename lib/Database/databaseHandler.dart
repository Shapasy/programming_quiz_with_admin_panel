import 'dart:math';
import 'question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static Database _db;

  static const String DATABASE = 'mydatabase1.db'; 
  static const int VERSION = 1;
  static const String TABLE_QUESTIONS = 'questions';
  static const String ID =  'id';
  static const String QUESTION = 'question'; 
  static const String ANSWER = 'answer';

  DatabaseHandler(){
    //delete all records from database
//    this.drop_database();
    //add all records to database
//    this.migrate_backup_to_database();
  }

 Future<Database> get db async {
    if (_db == null ){
      String path = join(await getDatabasesPath(), DATABASE);
      _db = await openDatabase(path, version: VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    }
    return _db;
  }

  _onCreate(Database db, int version) async{
    await db.execute('create table $TABLE_QUESTIONS ($ID integer primary key , $QUESTION text, $ANSWER text )');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    await db.execute('drop table $TABLE_QUESTIONS');
    await _onCreate(db, newVersion);
  }

  Future<Question> save(Question question) async {
    Database dbClient = await db;
    int id = await dbClient.insert(TABLE_QUESTIONS, { 'id' : question.id, 'question': question.question, 'answer': "${question.answer}"});
    question.id = id;
    return question;
  }

   Future<List<Question>>getQuestions() async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE_QUESTIONS, columns: [ID, QUESTION, ANSWER]);
    List<Question> questions = [];
    if (maps.length > 0) {
      for(var i = 0; i < maps.length; i++) {
        Map map = maps[i];
        bool f = map['answer'].toLowerCase() == 'true';
        Question question = new Question(map['id'], map['question'], f); 
        questions.add(question);
      }
    }
    return questions;
  }

  

  Future<int> delete (int id) async {
    Database dbClient = await db;
    int numOfRecords = await dbClient.delete(TABLE_QUESTIONS, where: '$ID=?', whereArgs: [id]);
    return numOfRecords;
  }

  Future<int>update(Question question) async {
    Database dbClient = await db;
    int numOfRecords = await dbClient.update(TABLE_QUESTIONS, {'question': question.question  ,'answer': "${question.answer}"}, where: '$ID = ?', whereArgs: [question.id]);
    return numOfRecords;
  }

  Future<Question>view(Question question) async {
    Database dbClient = await db;
    List<Map> maps1 = await dbClient.query(TABLE_QUESTIONS, columns: [QUESTION, ANSWER], where: '$ID = ?', whereArgs: [question.id]);
    question.question = maps1[0]['question'];
    bool b = maps1[0]['answer'] == 'true';
    question.answer =b;
    return question;
  }

  void drop_database() async{
    Database dbClient = await db;
    await dbClient.delete(TABLE_QUESTIONS, where: '$ID!=?', whereArgs: [-1]);
  }

  Future<List> get_random_questions(int num_questions) async{
    var data = await this.getQuestions();
    List random_questions = [];
    List<int> indices = this._get_special_random_numbers(data.length,num_questions);
    for(int index in indices){
      Question question = data[index];
      random_questions.add([question.question,question.answer]);
    }
    return random_questions;

  }

  List<int> _get_special_random_numbers(int range,int num_nums){
    List<int> random_nums = [];
    Random random = new Random();
    while(random_nums.length != num_nums){
      int random_num = random.nextInt(range);
      if(!random_nums.contains(random_num)){
        random_nums.add(random_num);
      }
    }
    return random_nums;
  }


 void migrate_backup_to_database() async{
   var records = {
     "Python is faster than C++.":false,
     "Bubble sort is the fastest sorting algorithm.":false,
     "Dynamic programming is used to overlapping subproblem.":true,
     "Normalization used to minimize data repetition in databases.":true,
     "Vue is a backend web framework.":false,
     "CNN is usually used in computer vision.":true,
     "RNN is usually used in computer vision.":false,
     ".Net framework is developed by amazon.":false,
     "We can use dijkstra algorithm even if we have a negative cycle.":false,
     "Using break inside loop can cause logical errors.":true,
     "In computer science There is space-time tradeoff.":true,
     "Array must be sorted in order to use binary search.":true,
     "R language is usually used in data analysis.":true,
     "MongoDB is sql databae.":false,
     "Flask is javascript framework.": false,
     "Flutter is used to only create mobile application.":false,
     "Javascript used to only create web application.":false,
     "C is an object oriented language.":false,
     "If x = (5>5 ? 5 : 4) then x is 5 ":false,
     "Dart programming language is developed by microsoft.":false,
     "HTML stands for extensible markup language.":false,
     "Java is cross-platform language.":true,
     "java double datatype is bigger than int datatype in size.":true,
     "CSS stands for Cascading Style Sheets.": true,
     "NPM is a package manager for Django.":false,
     "Angular is a TypeScript-based framework.":true,
     "PHP is used for back end development only.":true,
     "Angular framwork was developed by google.":true,
     "TCP/IP network model consists of 4 layers.":true,
     "UDP is a connecation oriented protocol.":false,
     "TCP sending data faster than UDP.":false,
     "Internet is a collection of computer network.":true,
     "Java class can inherit only one class.":true,
     "Fault is casuse of failure.":true,
     "ReLU is the most used activation function.":true,
     "XML stands for Hypertext Markup Language.":false,
     "WordPress software is written in PHP.":true,
     "Unity framework uses python.":false,
   };
   await records.forEach((question,answer) async{
      await this.save(Question(null, question, answer));
   });
 }


}