import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const UsersList(),
        appBar: AppBar(
          title: const Text("Описание бабочек"),
          centerTitle: true,
        ),
      )));
}

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  UsersListState createState() => UsersListState();
}

class UsersListState extends State<UsersList> {
  int _selectedIndex = -1;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchForm(),
          //_button(),
          _buildHorizontalList(),
          _buildSpacer(20),
          _buildText(),
          _buildSpacer(10),
          _buildImage(),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    bool flag = true;
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Поиск',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Название бабочки',
            suffixIcon: IconButton(
              onPressed: _controller.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Введите имя бабочки';
            return null;
          },
          onChanged: (value) {
            setState(() {});
            if (_formKey.currentState!.validate()) {
              for (int i = 0; i < butterfly.length; i++) {
                String nameButterfly = butterfly.elementAt(i).name;
                if (nameButterfly.startsWith(_controller.value.text)) {
                  flag = false;
                  _selectedIndex = i;
                }
              }
              if (flag) {
                _selectedIndex = -1;

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Такой бабочки "${_controller.value.text}" нет в списке'),
                  backgroundColor: Colors.red,
                ));
              }
            }
          },
        ),
      ),
    );
  }

  // Widget _button() {
  //   bool flag = true;
  //   return Container(
  //     margin: const EdgeInsets.all(20),
  //     width: MediaQuery.of(context).size.width * 0.4,
  //     height: MediaQuery.of(context).size.height * 0.05,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15),
  //       gradient: const LinearGradient(
  //         colors: [Color.fromARGB(255, 153, 207, 252), Colors.blue],
  //         begin: FractionalOffset.centerLeft,
  //         end: FractionalOffset.centerRight,
  //       ),
  //     ),
  //     child: TextButton(
  //       onPressed: () {
  //         setState(() {});
  //         if (_formKey.currentState!.validate()) {
  //           for (int i = 0; i < butterfly.length; i++) {
  //             String nameButterfly = butterfly.elementAt(i).name;
  //             if (nameButterfly.startsWith(_controller.value.text)) {
  //               flag = false;
  //               _selectedIndex = i;
  //             }
  //           }
  //           if (flag) {
  //             _selectedIndex = -1;

  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text(
  //                   'Такой бабочки "${_controller.value.text}" нет в списке'),
  //               backgroundColor: Colors.red,
  //             ));
  //           }
  //         }
  //       },
  //       child: const Text(
  //         'Найти',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHorizontalList() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(20),
          itemCount: butterfly.length,
          itemBuilder: (BuildContext context, int index) {
            Butter butter = butterfly[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: 255,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: _selectedIndex == index
                          ? Colors.blue
                          : Colors.black12,
                      width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.all(1),
                leading: ClipOval(
                  child: Image(
                    image: AssetImage(butter.image),
                    width: 50,
                    height: 35,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                title: Text(
                  butterfly.elementAt(index).name,
                  style: const TextStyle(fontSize: 24, color: Colors.blue),
                ),
                selected: index == _selectedIndex,
                selectedTileColor: Colors.black12,
              ),
            );
          }),
    );
  }

  Widget _buildText() {
    return Text(
      _selectedIndex == -1 ? ('') : butterfly.elementAt(_selectedIndex).desc,
      style: const TextStyle(
        fontSize: 22,
        color: Color.fromARGB(255, 3, 78, 140),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildImage() {
    return _selectedIndex == -1
        ? const Text(
            '',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          )
        : Image.asset(
            butterfly.elementAt(_selectedIndex).image,
            width: 200,
          );
  }
}

Widget _buildSpacer(double space) {
  return SizedBox(
    height: space,
  );
}

class Butter {
  String name;
  String desc;
  String image;
  Butter({
    required this.name,
    required this.desc,
    required this.image,
  });
}

List<Butter> butterfly = [
  Butter(
    name: 'Крапивница',
    desc:
        "Бабочка крапивница — одна из самых ярких и красочных представительниц дневных бабочек. Свое название она получила благодаря пищевым пристрастиям. Эти насекомые не только питаются крапивой, но и часто сидят на листьях данного растения, не боясь быть ужаленными. ",
    image: 'assets/images/krap.jpg',
  ),
  Butter(
    name: 'Павлиний глаз',
    desc:
        "Бабочка павлиний глаз относится к дневному виду семейства Нимфалиды. Принадлежат бабочки к членистоногим насекомым отряда чешуекрылых. Окрас их крыльев красно-бурого цвета с черно-красной окантовкой по краю.",
    image: 'assets/images/pavl.jpeg',
  ),
  Butter(
    name: 'Капустница',
    desc:
        "Бабочка-капустница представляет собой опасного врага овощных культур и хорошо знакома огородникам. Насекомое встречается практически во всех природных зонах нашей страны, за исключением северных регионов. Если вовремя не принять радикальных мер, направленных на уничтожение вредителя, существует высокий риск остаться без урожая. ",
    image: 'assets/images/kapus.jpg',
  ),
  Butter(
    name: 'Голубянка',
    desc:
        "Голубянка – дневная бабочка с необычным окрасом. Разнообразие мировой фауны ширится тысячами самых разных видом бабочек, как больших, так и маленьких, как ярких, так и темных. С этими чудесными насекомыми связано множество легенд и поверий, на пример, в древние времена, славяне относились к бабочкам уважительно, поскольку думали, что это души мёртвых. ",
    image: 'assets/images/golub.jpg',
  ),
  Butter(
    name: 'Переливница',
    desc:
        "Переливница ивовая — поразительно красивая бабочка, известная тем, что большую часть своего времени проводит в кронах деревьев. Поэтому, если ходите понаблюдать за этим видом, имеет смысл запастись биноклем. ",
    image: 'assets/images/pereliv.jpg',
  ),
  Butter(
    name: 'Траурница',
    desc:
        "Бабочка траурница – неутомимая путешественница и любительница хмельных напитков. Крупная дневная бабочка из семейства нимфалиды встречается по всей Палеарктике. Ее русское название «траурница» связано с темной окраской крыльев.",
    image: 'assets/images/traur.jpg',
  ),
];
