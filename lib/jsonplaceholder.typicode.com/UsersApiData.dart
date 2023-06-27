import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_practice/HTTP%20Services.dart';
import 'package:http_practice/Model%20Classes.dart';

class UsersApiData extends StatefulWidget {
  const UsersApiData({Key? key}) : super(key: key);

  @override
  State<UsersApiData> createState() => _UsersApiDataState();
}

class _UsersApiDataState extends State<UsersApiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsersApiData"),
      ),
      body: FutureBuilder(
          future: HTTPServices.getDataForUsers(),
          builder: (context, lateData) {
            if (lateData.hasData) {
              List<Users> userData = lateData.data!;
              return ListView.separated(
                itemCount: userData.length,
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Scaffold(
                                      appBar: AppBar(
                                        title: Text(userData[index].name),
                                      ),
                                      body: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              Container(

                                                alignment: Alignment.center,
                                                height: 300,
                                                child: const Icon(
                                                  Icons.account_circle,
                                                  color: Colors.teal,
                                                  size: 300,
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis
                                                    .horizontal,
                                                child: DataTable(
                                                    border: TableBorder.all(
                                                        borderRadius: BorderRadius
                                                            .circular(20),
                                                        width: 2,
                                                        color: CupertinoColors
                                                            .systemGreen),
                                                    columns: [
                                                      const DataColumn(
                                                          label: Text("ID")),
                                                      DataColumn(
                                                          label: Text(
                                                              userData[index]
                                                                  .id
                                                                  .toString()))
                                                    ],
                                                    rows: [
                                                      DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Username")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .username)),
                                                      ]),
                                                      DataRow(cells: [
                                                        const DataCell(Text(
                                                            "E-mail")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .email)),
                                                      ]), DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Address")),
                                                        DataCell(Text(
                                                            "${userData[index]
                                                                .suite}, ${userData[index]
                                                                .street}, ${userData[index]
                                                                .city} - (${userData[index]
                                                                .zipcode})")),
                                                      ]),
                                                      DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Latitude")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .lat)),
                                                      ]), DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Longitude")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .lng)),
                                                      ]),
                                                      DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Phone No.")),
                                                        DataCell(Text(
                                                            "+${userData[index]
                                                                .phone}")),
                                                      ]), DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Website")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .website)),
                                                      ]),
                                                      DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Company Name")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .companyName)),
                                                      ]), DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Company Catch Phrase")),
                                                        DataCell(Text(
                                                            userData[index]
                                                                .catchPhrase)),
                                                      ]),
                                                      DataRow(cells: [
                                                        const DataCell(Text(
                                                            "Company BS")),
                                                        DataCell(Text(
                                                            userData[index].bs
                                                        )),
                                                      ]),
                                                    ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))),
                    title: Text(userData[index].id.toString()),
                    subtitle: Text(
                        "Name : ${userData[index]
                            .name}\nWebsite : ${userData[index].website}"),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
