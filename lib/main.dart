import 'package:flutter/material.dart';
import 'package:flutter/services.dart';// для inputFormatters keyboardType

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();//обьявление переемнных
  final hei = TextEditingController();//длина
  final wei = TextEditingController();//ширина
  String param = 'задайте параметры';//переменная которое меняет значение на решение при коррктном вводе данных

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),//отсупы
      child:
      Form(
          key: _formKey,  //  константа для обращения и проверки   
          child: 
          Column(

            children: <Widget> [
              TextFormField( //тестовое поле
                decoration: InputDecoration(
                    hintText: "Введите ширину(число)", //подсказка
                    label: Text("Ширина (мм)"),//подпись поля
                    ),
                controller: wei,
                keyboardType: TextInputType.number,//использование типа клавиатуры в данном случае числовая клав-ра
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,//предотвращение вставки не чисел. digitsOnly принимает только числа
                ],
               
                validator: (value){
                  if (value!.isEmpty) return 'Введите ширину';// если поле пустое при нажатии кнопки, будет сообщение 'Введите ширину'
                }
              ),
              SizedBox(height: 20),
               TextFormField( decoration: InputDecoration(
                    hintText: "Введите длину(число)", label: Text("Длина (мм)"),
                    ),
                controller: hei,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value){
                  if (value!.isEmpty) return 'Введите длину';
                }
              ),
              SizedBox(height: 20),
              ElevatedButton(//кнопка вычислить 
                onPressed: () => _submitForm(),//когда кнопка нажата переходим к функции ниже с вычилениями 
                child: const Text('Вычислить'),//текст на кнопке
              ),
              SizedBox(height: 20),//отступ
              Center(
                child: Text(
                  param,
                  style: TextStyle(fontSize: 30),//размер шрифта теста после кнопки
                ),
              )
            ],
          )
          ),
    );
  }


  void _submitForm() {//код кнопки
    if (_formKey.currentState!.validate()) {
      int S = int.parse(hei.text) * int.parse(wei.text);//расчет площади
      setState(() {
        param = 'S = ${wei.text} * ${hei.text} = $S';//если все введено верно выводится решение
      });
    } else {
      setState(() {
        param = 'задайте параметры';//если параметры заданы неверно или не заданы param остается в начальном состоянии
      });
    }
  }
}
void main()=> runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(appBar: AppBar(title: const Text('Калькулятор')),//заголовок
    body: const FormPage()
    ,)
  )
);
