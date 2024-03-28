class AppUrl{
  static const String BASE_URL="https://dev4.pristinefulfil.com";
  static const String login_url="$BASE_URL/api/UserLogin/Login";
  static const String forgot_pass_url="$BASE_URL/api/UserLogin/ResetPasswordOTPSend";
  static const String create_pass_url="$BASE_URL/api/UserLogin/ResetPasswordOTPVerify";
  static const String profile_upload="$BASE_URL/api/UserLogin/ProfileUpload";

  //todo dash board.....
  static const String get_employee_master_details="$BASE_URL/api/Employee/EmployeeDetailGet";

  //todo checkin- checkout
  static const String vehileTypeGetInsert="$BASE_URL/api/Travel/VehicleTypeGet";
  static const String get_employee_master="$BASE_URL/api/Employee/EmployeeMasterGet";
  static const String userLocationInsert="$BASE_URL/api/Travel/UserLocationInsert";
  static const String currentRunningCheckInData="$BASE_URL/api/Travel/CurrentRunningCheckInData";
  static const String markCheckIn="$BASE_URL/api/Travel/MarkCheckIn";
  static const String getVehicleDetails="$BASE_URL/api/Travel/GetVehicleDetails";
  static const String markCheckOutSaveData="$BASE_URL/api/Travel/CheckOutDataSave";
  static const String expanseLineSaveSaveData="$BASE_URL/api/Travel/CheckOutLineExpenseSubmit";
  static const String checkOutComplete="$BASE_URL/api/Travel/CheckOutComplete";

  //todo
  static const String employeeTeamMemberGet="$BASE_URL/api/Employee/EmployeeTeamMemberGet";
  static const String check_in_approverData="$BASE_URL/api/Travel/CheckInApproverGet";
  static const String CheckInMarkApprove="$BASE_URL/api/Travel/CheckInMarkApprove";

  //todo show google map and rotes.........
  static const String getDateWiseUserCoordinate="$BASE_URL/api/Travel/GetDateWiseUserCoordinate";

  //todo for user expenses..................
  static const String getExpenseHeader="$BASE_URL/api/Expense/GetExpenseHeader";
  static const String getExpenseLines="$BASE_URL/api/Expense/GetExpenseLines";
  static const String getExpenseCatagory="$BASE_URL/api/Master/ExpenseCreate";
  static const String regionGet="$BASE_URL/api/GeographicalSetup/RegionGet";
  static const String expenseRegionGet="$BASE_URL/api/Expense/ExpenseRegionGet";
  static const String expenseCreate="$BASE_URL/api/Expense/ExpenseCreate";
  static const String expenseLinesSubmit="$BASE_URL/api/Expense/ExpenseLinesSubmit";
  static const String expenseComplete="$BASE_URL/api/Expense/ExpenseComplete";
  static const String expense_approverData="$BASE_URL/api/Expense/ExpenseApproverGet";
  static const String expenseMarkApprove="$BASE_URL/api/Expense/ExpenseMarkApprove";

  //todo orders .........................
  static const String orderHeaderGet="$BASE_URL/api/Order/OrderHeaderGet";
 // static const String getCustomers="$BASE_URL/api/Customer/CustomerGet";
  static const String getCustomers="$BASE_URL/api/Customer/CustomerGetGeoSetupWise";
  static const String getConsigneeMstGet="$BASE_URL/api/Customer/ConsigneeMstGet";
  static const String getPaymentTermsCreate="$BASE_URL/api/Customer/PaymentTermsCreate";
  static const String getStateList="$BASE_URL/api/Master/GetStateList";
  static const String consigneeMstInsertUpdate="$BASE_URL/api/Customer/ConsigneeMstInsertUpdate";
  static const String orderHeaderCreate="$BASE_URL/api/Order/OrderHeaderCreate";
  static const String itemCategoryMstGet="$BASE_URL/api/ItemMaster/ItemCategoryMstGet";
  static const String orderItemCategoryGet="$BASE_URL/api/Order/OrderItemCategoryGet";
  static const String orderItemGroupGet="$BASE_URL/api/Order/OrderItemGroupGet";
  static const String orderItemGet="$BASE_URL/api/Order/OrderItemGet";
  static const String orderLineInsert="$BASE_URL/api/Order/OrderLineInsert";
  static const String orderHeaderComplete="$BASE_URL/api/Order/OrderHeaderComplete";
  static const String orderINApproverGet="$BASE_URL/api/Order/OrderINApproverGet";
  static const String orderApprovalLineUpdate="$BASE_URL/api/Order/OrderApprovalLineUpdate";
  static const String OrderMarkApprove="$BASE_URL/api/Order/OrderMarkApprove";

  //todo for planting.......................
  static const String plantingHeaderGet="$BASE_URL/api/Planting/PlantingHeaderGet";
  static const String productionLocationGet="$BASE_URL/api/Planting/ProductionLocationGet";
  static const String seasonMstGet="$BASE_URL/api/Planting/SeasonMstGet";
  static const String plantingHeaderCreate="$BASE_URL/api/Planting/PlantingHeaderCreate";
  static const String PlantingHeaderLineDiscard="$BASE_URL/api/Planting/PlantingHeaderLineDiscard";
  static const String PlantingHeaderComplete="$BASE_URL/api/Planting/PlantingHeaderComplete";

  //todo for add line planting section.............
  static const String plantingFsioBsioDocumentGet="$BASE_URL/api/Planting/PlantingFsioBsioDocumentGet";
  static const String plantingFsioBsioDocumentDetailsGet="$BASE_URL/api/Planting/PlantingFsioBsioLotDetailsGet";
  static const String plantingLineCreate="$BASE_URL/api/Planting/PlantingLineCreate";
  static const String plantingLineGPSTag="$BASE_URL/api/Planting/PlantingLineGPSTag";
  static const String getSupervisior="$BASE_URL/api/Employee/SupervisiorGet";


  //todo for Inspection..........
  static const String InspectionProductionLotGetOnline="$BASE_URL/api/Inspection/InspectionProductionLotGetOnline";
  static const String moveToOfflineInspection="$BASE_URL/api/Inspection/InspectionProductionLotMoveToOffline";
  static const String moveToOnlineInspection="$BASE_URL/api/Inspection/InspectionProductionLotMoveToOnline";
  static const String inspectionProductionLotGetoffline="$BASE_URL/api/Inspection/InspectionProductionLotGetoffline";
  static const String inspectionProductionLotDeatailGet="$BASE_URL/api/Inspection/InspectionProductionLotDeatailGet";
  static const String inspectionComplete="$BASE_URL/api/Inspection/InspectionComplete";

  //todo for collection...........
  static const String collectionMasterGet="$BASE_URL/api/Collection/CollectionMasterGet";
  static const String collectionMasterCreate="$BASE_URL/api/Collection/CollectionMasterCreate";


  //todo for productonground........
  static const String zoneGet="$BASE_URL/api/GeographicalSetup/ZoneGet";
  static const String itemGroupMstGet="$BASE_URL/api/ItemMaster/ItemGroupMstGet";
  static const String itemMstGet="$BASE_URL/api/ItemMaster/ItemMstGet";
  static const String productOnGroundCreate="$BASE_URL/api/ProductOnGround/ProductOnGroundCreate";
  static const String productOnGroundGet="$BASE_URL/api/ProductOnGround/ProductOnGroundGet";
  static const String productOnGroundComplete="$BASE_URL/api/ProductOnGround/ProductOnGroundComplete";
  static const String productOnGroundUpdate="$BASE_URL/api/ProductOnGround/ProductOnGroundUpdate";
  static const String productOnGroundApprovalGet="$BASE_URL/api/ProductOnGround/ProductOnGroundApprovalGet";
  static const String productOnGroundApprove="$BASE_URL/api/ProductOnGround/ProductOnGroundApprove";
  static const String productOnGroundDiscard="$BASE_URL/api/ProductOnGround/ProductOnGroundDiscard";


  //todo customer......
  static const String getCustomerList="$BASE_URL/api/Customer/CustomerGet";
  static const String getCustomerGeoTag="$BASE_URL/api/Customer/CustomerGeoTagUpdateAssign";
  //todo for Notification......
  static const String getNotification="$BASE_URL/api/PushNofication/GetNotificationList";
  static const String userFireBaseTokenUpdate="$BASE_URL/api/UserLogin/UserFireBaseTokenUpdate";

  //todo for seed dispatch note
  static const String seedDispatchHeaderCreate="$BASE_URL/api/DispatchNote/DispatchHeaderCreate";
  static const String seedDispatchHeaderGet="$BASE_URL/api/DispatchNote/DispatchHeaderGet";
  static const String seedDispatchLineCreate="$BASE_URL/api/DispatchNote/DispatchLineCreate";
  static const String seedDispatchLineGet="$BASE_URL/api/DispatchNote/DispatchLineGet";
  static const String seedDispatchLineUpdate="$BASE_URL/api/DispatchNote/DispatchLineUpdate";
  static const String seedDispatchLocation="$BASE_URL/api/Master/GetLocationList";
  static const String itemGroupCategoryMstGet="$BASE_URL/api/ItemMaster/ItemGroupMstGet";
  static const String itemmastermst="$BASE_URL/api/ItemMaster/ItemMstGet";
  static const String discardHeaderApi="$BASE_URL/api/DispatchNote/DispatchHeaderDelete";
  static const String discardLineApi="$BASE_URL/api/DispatchNote/DispatchLineDelete";
  static const String completeHeaderApi="$BASE_URL/api/DispatchNote/DispatcHeaderComplete";
  static const String getLotNo="$BASE_URL/api/Planting/ProductionLotNoGet";



  //todo for event management
  static const String getEvetntTypeApi="$BASE_URL/api/EventManagement/GetEventType";
  static const String getEvetntTExpenseApi="$BASE_URL/api/EventManagement/GetEventExpense";
  static const String getEvetntTDeleteApi="$BASE_URL/api/EventManagement/EventTypeDelete";
  static const String getEventManagementApproverApi="$BASE_URL/api/EventManagement/EventManagementApproverGet";

  static const String eventTypeCreate="$BASE_URL/api/EventManagement/EventTypeCreate";
  static const String eventManagementGet="$BASE_URL/api/EventManagement/EventManagementGet";
  static const String eventManagementCreate="$BASE_URL/api/EventManagement/EventManagementCreate";
  static const String eventManagementExpenseInsert="$BASE_URL/api/EventManagement/EventManagementExpenseInsert";
  static const String eventManagementComplete="$BASE_URL/api/EventManagement/EventManagementComplete";
  static const String eventApprovalRejected="$BASE_URL/api/EventManagement/EventManagementApproveReject";
  static const String eventUploadImage="$BASE_URL/api/Master/FileUploader";
  static const String imageDiscardApi="$BASE_URL/api/Master/FileDiscard";


  //todo for customerRequest Api.......
  static const String customerRequestList="$BASE_URL/api/Customer/CustomerRequestGet";
  static const String customerRequestCreate="$BASE_URL/api/Customer/CustomerRequestCreate";
  static const String getCustomerType="$BASE_URL/api/Customer/GetCustomerType";
  static const String getVenderType="$BASE_URL/api/Customer/GetVendorType";
  static const String getSalePerson="$BASE_URL/api/Customer/SalesPersonGet";
  static const String customerRequestUpdate="$BASE_URL/api/Customer/CustomerRequestUpdate";
  static const String customerRequestComplete="$BASE_URL/api/Customer/CustomerRequestComplete";
  static const String customerRequestApprovarList="$BASE_URL/api/Customer/CustmerRequestApproverGet";
  static const String customerRequestApprovarRejected="$BASE_URL/api/Customer/CustmerRequestApproveReject";



   //todo for Ipt Api........

  static const String iptgetList="$BASE_URL/api/IPT/IPTHeaderGet";
  static const String createipt="$BASE_URL/api/IPT/IPTHeaderCreate";
  static const String getItemCategory="$BASE_URL/api/IPT/IPTItemCategoryGet";
  static const String getItemGroup="$BASE_URL/api/IPT/IPTItemGroupGet";
  static const String getIptItemGet="$BASE_URL/api/IPT/IPTItemGet";

  static const String iptLineInsert="$BASE_URL/api/IPT/IPTLineInsert";
  static const String iptHeaderComplete="$BASE_URL/api/IPT/IPTHeaderComplete";
  static const String iptLotNo="$BASE_URL/api/IPT/IPTLotGet";
  static const String iptApproverList="$BASE_URL/api/IPT/IPTApproverGet";
  static const String iptApproverLineUpdate="$BASE_URL/api/IPT/IPTApprovalLineUpdate";
  static const String iptApproverCompleteRejected="$BASE_URL/api/IPT/IPTMarkApprove";


  //todo for shipped order........
  static const String shipmentOrderGet="$BASE_URL/api/Order/ShipmentOrderGet";

}