import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:flutter/material.dart';

class Awareness extends StatefulWidget {
  const Awareness({Key? key}) : super(key: key);

  @override
  State<Awareness> createState() => _AwarenessState();
}

class ItemLists {
  int? count;
  String? titl;
  String? description;
  String? image;
  ItemLists({
    this.count,
    required this.titl,
    required this.description,
    this.image,
  });
}

class _AwarenessState extends State<Awareness> {
  List<ItemLists> previtems = [
    ItemLists(
      image: "null",
      count: 1,
      titl: 'Eliminate breeding grounds',
      description:
          'Dengue-carrying mosquitoes breed in stagnant water, so eliminate standing water in and around your home by cleaning and covering containers that store water such as flower pots, discarded tires, and other places where water can accumulate.',
    ),
    ItemLists(
      image: "null",
      count: 2,
      titl: 'Wear protective clothing',
      description:
          'Wear clothing that covers your skin as much as possible when you are outside, especially during the day when mosquitoes are most active. Use mosquito repellent products on exposed skin and clothing.',
    ),
    ItemLists(
      image: "null",
      count: 3,
      titl: 'Keep your environment clean',
      description:
          'Keep your surroundings clean and free from any unnecessary clutter that may harbor mosquitoes.',
    ),
    ItemLists(
      image: "null",
      count: 4,
      titl: 'Use mosquito nets',
      description:
          'Use mosquito nets when sleeping, especially during the daytime, as this is when dengue mosquitoes are most active.',
    ),
    ItemLists(
      image: "null",
      count: 5,
      titl: 'Seek immediate medical attention',
      description:
          'If you experience any symptoms of dengue fever, seek immediate medical attention. Treatment for dengue focuses on relieving symptoms, and early diagnosis and treatment can significantly reduce the risk of severe complications.',
    ),
    ItemLists(
      image: "null",
      count: 6,
      titl: 'Be aware of your surroundings',
      description:
          'Pay attention to dengue outbreaks in your area and take appropriate measures to protect yourself, especially during peak mosquito seasons.',
    ),
  ];

  List<ItemLists> symitems = [
    ItemLists(
      count: 1,
      titl: 'High fever',
      description: 'Davido',
      image: "assets/awareness/Fever.png",
    ),
    ItemLists(
      count: 2,
      titl: 'Severe headache',
      description: 'Brighter Press',
      image: "assets/awareness/Headache.png",
    ),
    ItemLists(
      count: 3,
      titl: 'Pain behind the eyes',
      description: 'Simi-Sola',
      image: "assets/awareness/eye.png",
    ),
    ItemLists(
      count: 4,
      titl: 'Muscle pain',
      description: 'Black Camaru',
      image: "assets/awareness/Muscle.png",
    ),
    ItemLists(
      count: 5,
      titl: 'Nausea and vomiting',
      description: 'ShofeniWere',
      image: "assets/awareness/Vomiting.png",
    ),
    ItemLists(
      count: 6,
      titl: 'Skin rash',
      description: 'ShofeniWere',
      image: "assets/awareness/Rash.png",
    ),
    ItemLists(
      count: 7,
      titl: 'Bone pain',
      description: 'ShofeniWere',
      image: "assets/awareness/Bone.png",
    ),
    ItemLists(
      count: 8,
      titl: 'Joint pain',
      description: 'ShofeniWere',
      image: "assets/awareness/Joints.png",
    ),
  ];
  int? count = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: ScfColor,
          appBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            splashBorderRadius: BorderRadius.circular(25),
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              //bottom: 0,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            //indicatorColor: Colors.amber,
            indicator: BoxDecoration(
                //shape: BoxShape.rectangle,
                border: const Border.symmetric(),
                borderRadius: BorderRadius.circular(25), // Creates border
                color: btnColor), //Change background color from here
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const Tab(
                height: 50,
                text: "Symptoms",
              ),
              const Tab(
                height: 50,
                text: "Preventions",
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: TabBarView(
              // clipBehavior: Clip.antiAlias,
              children: [
                ListView.builder(
                  itemCount: symitems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      //                           <-- Card widget
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('${symitems[index].image}'),
                          ),
                          title: Text(
                            "${symitems[index].titl}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: txtColor,
                              fontSize: 20,
                            ),
                          ),
                          // subtitle: Text(
                          //   "${symitems[index].description}",
                          //   style: GoogleFonts.gemunuLibre(
                          //     fontWeight: FontWeight.w400,
                          //     color: btnColor,
                          //     fontSize: 20,
                          //   ),
                          // ), //           <-- subtitle
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: previtems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      //                           <-- Card widget
                      child: ListTile(
                        // leading: const CircleAvatar(
                        //   backgroundImage:
                        //       AssetImage('assets/images/Profile Image.png'),
                        // ),
                        leading: TextWidget(
                            title: "${previtems[index].count}",
                            txtSize: 50,
                            txtColor: btnColor),
                        title: Text(
                          "${previtems[index].titl}",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: txtColor,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          "${previtems[index].description}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ), //           <-- subtitle
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
