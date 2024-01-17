import 'package:app_isar/collections/category.dart';
import 'package:isar/isar.dart';
part 'routine.g.dart';

@Collection()
class Routine{

  Id? id = Isar.autoIncrement;

  String? title;

  @Index() //^ Ordenar de forma descendente
  DateTime? startTime;
  
  @Index(caseSensitive: false) //^ Puede buscar sin importar mayusculas o minusculas
  String? day;

  @Index(composite:[CompositeIndex('title')]) //^ Esta asociada a title
  final category = IsarLink<Category>(); //* Vincula o relaciona 2 collecciones

}