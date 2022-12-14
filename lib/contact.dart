import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(
      MaterialApp(
          home: MyApp()
      )
  );//앱 시작해주세요~
}



class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const 같은 것은 쓸데가 없기 때문에 보이는건 다 지워도 된다.

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      ContactsService.getContacts();

    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();

    }
  }


  var name = ['침착맨', '주펄','풍','기안'];
  var like = [0,0,0,0];
  var total = 4;

  addName(a){
    setState(() {
      name.add(a);
    });
  }

  addOne(){
    setState(() {
      total++;
    });
  }

  get children => null;

  @override
  build(context) {
    //여기서부터가 앱 디자인하는 부분
    //flutter에서 앱디자인 넣는 법 위젯 짜집기
    return Scaffold(
        floatingActionButton: Center(
          child: Builder(
              builder: (context) {
                return FloatingActionButton(
                  onPressed: (){

                    showDialog(context: context, builder: (context){
                      return DialogUI( addOne : addOne, addName : addName );
                    }
                    );
                  },child: Icon(Icons.add),
                );
              }
          ),
        ),
        appBar: AppBar(
          title: Text('전화번호 목록 (' + total.toString() + ')'),
          actions: [
            IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
          ],
        ),
        body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (context,i) {
            print(i);
            return ListTile(
              leading : Image.asset('assets/profile.jpg'),
              title : Text(name[i]),

            );
          },
        )

    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.addName}) : super(key: key);
  final addOne;
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            Text('Contact'),
            TextField( controller: inputData, ),
            Text(inputData.text),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){ Navigator.pop(context); }, child: Text("Cancel")),
                TextButton(
                    onPressed: (){
                      addOne();
                      addName(inputData.text);
                    },
                    child: Text('OK ')),
              ],
            )
          ],
        ),
      ),
    );;
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Image.asset('mycode.jpg', width: 150),

            Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('캐논 DSLR 100D (단렌즈,충전기 16기가 SD 포함)'),
                  Text('강일동, 끌올 10분전'),
                  Text('3000원'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite),
                      Text('4'),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}