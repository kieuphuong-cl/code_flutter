import 'package:flutter/widgets.dart';
import 'product.dart';

class ProductVM with ChangeNotifier {
  List<Product> lst = [];
  List<int> amounts = [];
  static const int initiate = 1;
  int count = 0;
  add(Product pro) {
    if (!lst.contains(pro)) {
      lst.add(pro);
      amounts.add(initiate);
    } else {
      amounts[lst.indexOf(pro)]++;
    }
    count = 0;
    updateCount();
    notifyListeners();
  }

  del(int index) {
    lst.removeAt(index);
    amounts[index]--;
    count = 0;
    updateCount();
    notifyListeners();
  }

  delPro(Product pro) {
    if (amounts[lst.indexOf(pro)] > 1) {
      amounts[lst.indexOf(pro)]--;
    } else {
      amounts[lst.indexOf(pro)]--;
      amounts.remove(lst.indexOf(pro));
      lst.remove(pro);
    }
    count = 0;
    updateCount();
    notifyListeners();
  }

  delAll() {
    lst.clear();
    amounts.clear();
    count = 0;
    updateCount();
    notifyListeners();
  }

  updateCount() {
    for (int i = 0; i < amounts.length; i++) {
      count += amounts[i];
    }
  }
}
