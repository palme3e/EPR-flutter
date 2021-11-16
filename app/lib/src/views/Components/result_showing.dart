import 'package:flutter/material.dart';

class Item {
  Item({this.expandedValue, this.expandedHeader, this.active = false});

  String expandedValue;
  String expandedHeader;
  bool active;
}

generate_exp_panel(Item item) {
  //List<Item> item_list = generate_item(complications);
  return new ExpansionPanelList(
    expansionCallback: (panelIndex, isExpanded) {
      item.active = !item.active;
      //setState(() {});
    },
    children: <ExpansionPanel>[
      ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return Text(
              item.expandedHeader,
              style: TextStyle(color: Colors.black, fontSize: 16),
            );
          },
          body: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 7,
            children: [
              Text(
                item.expandedValue,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                "Click here read more about this.",
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
          isExpanded: item.active,
          canTapOnHeader: true)
    ],
  );
}

generate_item(List complications) {
  List<Item> item_list = [];
  for (Map comp in complications) {
    item_list.add(new Item(
        expandedHeader: comp["complication"].toString() +
            " " +
            comp["severity_str"].toString(),
        expandedValue: "Your risk of getting this complication is " +
            comp["risk_percent"].toString() +
            "%"));
  }

  List temp = [];
  for (var item in item_list) {
    temp.add(Row(children: [generate_exp_panel(item)]));
  }
  return temp;
}




// Row result_component(Map complication) => Row(
//       children: [
//         Text("Complication " + complication["complication"].toString() + " ",
//             style: TextStyle(color: Colors.black, fontSize: 15)),
//         Text("Serverity str" + complication["severity_str"].toString() + " ",
//             style: TextStyle(color: Colors.black, fontSize: 15)),
//         Text("Risk str " + complication["risk_str"].toString() + " ",
//             style: TextStyle(color: Colors.black, fontSize: 15)),
//         Text("Risk score " + complication["risk_score"].toString() + " ",
//             style: TextStyle(color: Colors.black, fontSize: 15)),
//         Text("Risk precent " + complication["risk_precent"].toString() + " ",
//             style: TextStyle(color: Colors.black, fontSize: 15)),
//       ],
//     );