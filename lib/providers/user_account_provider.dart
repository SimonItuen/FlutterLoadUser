import 'package:flutter/material.dart';
import 'package:load/model/card_model.dart';
import 'package:load/model/load_reward_items_model.dart';
import 'package:load/model/load_reward_model.dart';
import 'package:load/model/reward_model.dart';
import 'package:load/model/trending_model.dart';
import 'package:load/model/user_model.dart';
import 'package:load/model/store_model.dart';

class UserAccountProvider with ChangeNotifier {
  UserModel _userModel = UserModel();
  StoreModel _storeModel = StoreModel();
  RewardModel _tempRewardModel = RewardModel();
  bool openRestaurant = false;
  bool firstOpened = false;
  bool homeLoading = false;
  List<LoadRewardItemsModel> loadRewardItemsList = List<LoadRewardItemsModel>();
  List<LoadRewardModel> loadRewards = List<LoadRewardModel>();
  List<LoadRewardModel> loadRewardHistory = List<LoadRewardModel>();
  List<TrendingModel> trendList = List<TrendingModel>();
  List<CardModel> cardList = List<CardModel>();

  /*ServiceModel _serviceModel  = ServiceModel();
  WalletModel _walletModel= WalletModel();
  String tempEmail= '';
  KonveyoUserModel _konveyoUserModel = KonveyoUserModel();
  List<ScheduleModel> _list = List<ScheduleModel>();
  RouteModel _routeModel = RouteModel(
      starting: Places(name: 'N/A', latitude: 0.0, longitude: 0.0),
      destination: Places(name: 'N/A', latitude: 0.0, longitude: 0.0));*/

  /*bool isAvailable = false;*/
  bool isLoadClicked = false;
  bool isMyRewardClicked = false;
  bool stillStayInPartnerClicked = false;
  String temPhone = '';
  String temToken = '';
  String temEmail = '';
  String helpLine = '';
  String storeId = '0';
  String categoryId = '0';
  String partner = 'Our Partners';

  void setCategoryId(String s) {
    categoryId = s;
    notifyListeners();
  }

  void setPartner(String s) {
    partner = s;
    notifyListeners();
  }

  void setStoreId(String s) {
    storeId = s;
    setStoreDetails(new StoreModel());
    notifyListeners();
  }

  void setHomeLoading(bool b) {
    homeLoading = b;
    notifyListeners();
  }

  void setFirstOpened(bool b) {
    firstOpened = b;
    notifyListeners();
  }

  void setOpenRestaurant(bool b) {
    openRestaurant = b;
    notifyListeners();
  }

  void setStillStayInPartnerClick(bool b) {
    stillStayInPartnerClicked = b;
    notifyListeners();
  }

  void setLoadClick(bool b) {
    isLoadClicked = b;
    notifyListeners();
  }

  void setTrendsList(List<TrendingModel> list) {
    trendList = list;
    notifyListeners();


  }void setCardsList(List<CardModel> list) {
    cardList = list;
    notifyListeners();

  }
  void setLoadRewardList(List<LoadRewardItemsModel> list) {
    loadRewardItemsList = list;
    notifyListeners();


  }void setLoadRewards(List<LoadRewardModel> list) {
    loadRewards = list;
    notifyListeners();

  }void setLoadRewardsHistory(List<LoadRewardModel> list) {
    loadRewardHistory= list;
    notifyListeners();
  }

  void setMyRewardClicked(bool b) {
    isMyRewardClicked = b;
    notifyListeners();
  }

  void setStoreDetails(StoreModel model) {
    _storeModel = model;
    notifyListeners();
  }

  void setTempSingleReward(RewardModel model) {
    _tempRewardModel = model;
    notifyListeners();
  }

  void setUserDetails(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  void appendUserDetails(String points) {
    _userModel.points = points;
    notifyListeners();
  }

  void setTempToken(String s) {
    temToken = s;
    notifyListeners();
  }

  void setTempPhone(String s) {
    temPhone = s;
    notifyListeners();
  }

  void setTempEmail(String s) {
    temEmail = s;
    notifyListeners();
  }

  void setHelpLine(String s) {
    helpLine = s;
    notifyListeners();
  }

  StoreModel get getStoreModel {
    return _storeModel;
  }

  RewardModel get getTempRewardModel {
    return _tempRewardModel;
  }

  String get getFullName {
    return '${_userModel.name.substring(0, 1).toUpperCase()}${_userModel.name.substring(1, _userModel.name.length)}';
  }

  String get getEmail {
    return _userModel.email;
  }

  String get getId {
    return _userModel.id.toString();
  }

  String get getHelpLine {
    return helpLine;
  }

  /*String get getLanguage {
    return _userModel.language;
  }

  Places get getStarting {
    return _routeModel.starting;
  }

  Places get getDestination {
    return _routeModel.destination;
  }

  String get getCountry {
    return _userModel.country;
  }*/

  String get getPhone {
    return _userModel.phone;
  }

  String get getProfileUrl {
    return _userModel.profileImg;
  }

  String get getAccessToken {
    return _userModel.apiToken;
  }

  String get getStatus {
    return _userModel.status;
  }

  String get getRole {
    return _userModel.role;
  }

  String get getPoints {
    return _userModel.points.replaceAll('null', '0');
  }

  String get getTempPhone {
    return temPhone;
  }

  String get getTempToken {
    return temToken;
  }

  String get getTempEmail {
    return temEmail;
  }

  String get getStoreId {
    return storeId;
  }

  String get getCategoryId {
    return categoryId;
  }

  String get getPartner {
    return partner;
  }

  bool get getHomeLoading {
    return homeLoading;
  }

  bool get getFirstOpened {
    return firstOpened;
  }

  bool get getOpenRestaurant {
    return openRestaurant;
  }

  bool get getLoadClicked {
    return isLoadClicked;
  }

  bool get getMyRewardClicked {
    return isMyRewardClicked;
  }

  bool get getStillStayInPartnerClicked {
    return stillStayInPartnerClicked;
  }

  List<LoadRewardItemsModel> get getLoadRewardItemsList {
    return loadRewardItemsList;
  }

  List<LoadRewardModel> get getLoadRewardList {
    return loadRewards;
  }

  List<LoadRewardModel> get getLoadRewardHistoryList {
    return loadRewardHistory;
  }

  List<TrendingModel> get getTrendingList {
    return trendList;
  }

  List<CardModel> get getCardList {
    return cardList;
  }
}
