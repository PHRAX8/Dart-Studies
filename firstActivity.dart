import 'dart:core';

void main() {
  Product vassoura = Product(15.50,"Broom");
  Product escova = Product(5.20,"Toothbrush");
  Product panela = Product(25.00,"Frying Pan");
  Item i1 = Item(5, vassoura);
  Item i2 = Item(3, escova);
  Item i3 = Item(1, panela);
  List<Item> listaDeItem = [i1,i2,i3];
  Sale venda = Sale(listaDeItem);
  venda.display();
}

class Product {
  double price;
  String description;
  
  Product(this.price, this.description);
  
  void display() {
    print("Description: ${this.description}");
    print("Price: ${this.price} Reais");
  }
}

class Item extends Product{
  int quantity;
  Product _product = Product(0,'');

  Item(this.quantity, product) : super(product.price, product.description){
    _product = product;
  }

  double totalItem(){
    return quantity * _product.price;
  }
    
  void display() {
    super.display();
    print("Quantity: ${this.quantity} Units");
  }
}

class Sale{
  String date = '';
  List<Item> _list = [];
  
  Sale(list){
    date = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} at ${DateTime.now().hour}:${DateTime.now().minute}";
    _list = list;
  }

  double totalSale(){
    List<double> doubleList = [];
    _list.forEach((element)=>{
      doubleList.add(element.totalItem())
    });
    double sumItem = doubleList.reduce(
    (firstItem, secondItem) => firstItem + secondItem
    );
    return sumItem;
  }
  
  void display() {
    print("Date: ${this.date}");
    _list.forEach((element)=>{
      element.display()
    });
    print("Total: ${totalSale()} Reais");
  }
}