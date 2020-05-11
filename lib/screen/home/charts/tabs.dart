import 'package:flutter/material.dart';
import 'contactsChart.dart';
import 'opportunity.dart';

class ChartTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x0000000),
          elevation: 0.0,
          flexibleSpace: SafeArea(
            child: TabBar(
              unselectedLabelColor: Colors.grey[400],
              labelColor: Color(0xFF3baee7),
              tabs: [
                Tab(
                  text: "CLIENTS AREA",
                ),
                Tab(
                  text: "SAELS GOAL",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            DatumLegendWithMeasures.withSampleData(),
            DonutAutoLabelChart.withSampleData(),
          ],
        ),
      ),
    );
  }
}
