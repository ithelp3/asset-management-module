import 'package:asset_management_module/component_widget/skeleton_dashboard.dart';
import 'package:asset_management_module/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

@override
Widget dashboard(BuildContext context, HomeController ctr) {
  // double height = MediaQuery.of(context).size.height;
  return Scaffold(
    key: const ValueKey(0),
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(ctr.user.company ?? '',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            centerTitle: false,
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(ctr.user.urlLogo!),
                  fit: BoxFit.cover,
                  onError: (url, err) => ctr.errorBanner.value = true
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 60),
              child: ctr.errorBanner.value ? Image.network(ctr.user.urlLogo!,
                fit: BoxFit.cover,
                errorBuilder: (ctx, url, err) {
                  return const Icon(Icons.home_work_outlined, size: 140, color: Colors.white,);
                },
              ) : null,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              if(!ctr.progressDashboard.value) Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                height: 260,
                child: Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('Asset by Status',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Icon(Icons.expand_less_outlined, size: 36,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: PieChart(
                          dataMap: {
                            for(final item in ctr.pieChartAssetByCategory) item.name?.toString() ?? 'N/A': double.tryParse(item.total.toString()) ?? 0,
                          },
                          colorList: const [
                            Color(0XFF3F87B9),
                            Color(0XFF75B7EC),
                            Color(0XFFFDC543),
                            Color(0XFFE08241),
                          ],
                          chartLegendSpacing: 20,
                          chartValuesOptions: const ChartValuesOptions(
                            decimalPlaces: 0,
                            chartValueBackgroundColor: Colors.white,
                          ),
                          chartRadius: MediaQuery.of(context).size.width/2.4,
                        ),
                      ),
                    ],
                  ),
                )
              ) else skeletonPie(),
              if(!ctr.progressDashboard.value) Container(
                margin: const EdgeInsets.all(10),
                height: 260,
                alignment: Alignment.centerLeft,
                child: Card(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('Asset by Status',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Icon(Icons.expand_less_outlined, size: 36,)
                          ],
                        ),
                      ),
                      PieChart(
                        dataMap: {
                          for(final item in ctr.pieChartAssetByStatus) item.name?.toString() ?? 'N/A': double.tryParse(item.total.toString()) ?? 0,
                        },
                        colorList: const [
                          Color(0XFF3F87B9),
                          Color(0XFF75B7EC),
                          Color(0XFFFDC543),
                          Color(0XFFE08241),
                        ],
                        chartLegendSpacing: 20,
                        chartValuesOptions: const ChartValuesOptions(
                          decimalPlaces: 0,
                          chartValueBackgroundColor: Colors.white,
                        ),
                        chartRadius: MediaQuery.of(context).size.width/2.4,

                      ),
                    ],
                  ),
                )
              ) else skeletonPie(),
              Card(
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('pengajuan',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(0.5),
                          2: FlexColumnWidth(0.5),
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade200),
                          // bottom:
                        ),
                        children: [
                          const TableRow(
                            children: [
                              Text('Asset',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('Priority',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('Date',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                            ]
                          ),
                          ...ctr.submission.map((item) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text(item.name ?? '-',
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF3f87b9),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text(item.description ?? '-',
                                    style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text(item.date ?? '-',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 13)),
                              ),
                            ]
                          ))
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Recent Asset Activity',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(0.5),
                          2: FlexColumnWidth(0.5),
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade200),
                          // bottom:
                        ),
                        children: [
                          const TableRow(
                            children: [
                              Text('Asset',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('Status',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('Date',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                            ]
                          ),
                          ...ctr.recentAssets.map((item) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text(item.asset ?? '-',
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3f87b9),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text(item.statusName ?? '-',
                                    style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text(item.date ?? '-',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 13)),
                              ),
                            ]
                          ))
                        ],
                      ),
                    ),
                  ],
                )
              ),Card(
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Recent Component Activity',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(0.5),
                          2: FlexColumnWidth(0.5),
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade200),
                          // bottom:
                        ),
                        children: [
                          const TableRow(
                            children: [
                              Text('Asset',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('Priority',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('Data',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                            ]
                          ),
                          ...ctr.recentComponents.map((item) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text(item.component ?? '-',
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF3f87b9),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Text(item.statusName ?? '-',
                                    style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Text(item.date ?? '-',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 13)),
                              ),
                            ]
                          ))
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        )
      ],
    ),
  );
}