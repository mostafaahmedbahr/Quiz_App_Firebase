import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/screens/fav/cubit/states.dart';

import '../../../Sh/shared_pref.dart';
import '../../../models/fav_model.dart';


class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(FavInitialState());

  static FavCubit get(context) => BlocProvider.of(context);


  final instance = FirebaseFirestore.instance;
  List<FavouriteModel> favList = [];

  void getAllFavourite() {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(SharedPreferencesHelper.getData(key: "uId"))
        .collection("favourite")
        .withConverter<FavouriteModel>(
      fromFirestore: (snapshot, options) {
        print(snapshot.data());
        return FavouriteModel.fromFirestore(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toFirestore();
      },
    ).snapshots()
        .listen(
          (event) {
        favList = event.docs.map((element) => element.data()).toList();
      },
    );
  }


  FavouriteModel? favouriteModel;

  addToFav({
    required FavouriteModel favouriteModel
}) async {
    emit(AddToFavouriteLoading());
    try {
      await instance
          .collection("AllUsers")
          .doc(SharedPreferencesHelper.getData(key: "uId"))
          .collection("favourite")
          .doc(favouriteModel.id)
          .set(favouriteModel.toFirestore());
      emit(AddToFavouriteSuccess());
    } catch (e) {
      print('error message = ${e.toString()}');
      emit(AddToFavouriteError());
    }
//   on<AddProductToFavorite>((event, emit) async {
//   emit(AddToFavouriteLoading());
//   try {
//   await instance
//       .collection("AllUsers")
//       .doc(userId)
//       .collection("favourite")
//       .doc(event.favourite!.id)
//       .set(event.favourite!.toFirestore());
//   emit(AddToFavouriteSuccess(message: 'Product Added'));
//   } catch (e) {
//   print('error message = ${e.toString()}');
//   emit(AddToFavouriteError(message: e.toString()));
//   }
// });

  }
}