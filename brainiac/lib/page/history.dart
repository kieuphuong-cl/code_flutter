import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/api.dart';
import '../model/category.dart';
import '../model/history.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  List<CategoryModel> lstCate = [];
  List<History> lsthistory = [];
  Future<List<CategoryModel>> getCateList() async {
    // getDataUser();
    lstCate = await APIRepository().getCategoryList();
    return lstCate;
  }

  Future<List<History>> getHistory() async {
    lsthistory = await APIRepository().getHistory();
    return lsthistory;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHistory(),
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 250, 180, 87)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              child: ListView.builder(
                itemCount: lsthistory.length,
                itemBuilder: (context, index) {
                  return _buildCategory(lsthistory[index], context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategory(History breed, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // căn phải các phần tử trong hàng ngang
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(breed.id!),
                Text('Date Created: ${breed.dateCreated!}'),
                Text(
                  'Total: ' +
                      NumberFormat('###,###,###').format(breed.total) +
                      " VND",
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Xác nhận'),
                      content: const Text('Bạn muốn xoá lịch sử?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Hủy'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Xóa'),
                          onPressed: () {
                            // Gọi hàm xóa lịch sử ở đây
                            Navigator.of(context).pop();
                            setState(() {
                              // Cập nhật lại danh sách lịch sử sau khi xóa
                              lsthistory.remove(breed);
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
