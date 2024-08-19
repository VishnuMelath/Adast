import 'package:adast/models/cloth_model.dart';

int totalItemsLeft(ClothModel clothModel) {
  return clothModel.size.values.fold<int>(
        0,
        (previousValue, element) => previousValue + int.parse(element.toString()),
      ) -
      (clothModel.soldCount.values.fold<int>(
        0,
        (previousValue, element) => previousValue + (element as int),
      )+clothModel.reservedCount.values.fold<int>(
        0,
        (previousValue, element) => previousValue + (element as int),
      ));
}

int itemsLeftPerSize(ClothModel clothModel,String size)
{
  return int.parse(clothModel.size[size].toString())-(int.parse((clothModel.soldCount[size]??0).toString())+int.parse(clothModel.reservedCount[size]?.toString()??'0'));
}