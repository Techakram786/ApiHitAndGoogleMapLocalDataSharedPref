import 'package:get/get.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view/IPT/ipt_approver_view_card.dart';
import 'package:pristine_seeds/view/IPT/ipt_header_list.dart';
import 'package:pristine_seeds/view/IPT/ipt_item_category_screen.dart';
import 'package:pristine_seeds/view/IPT/ipt_item_varieties_screen.dart';
import 'package:pristine_seeds/view/IPT/ipt_item_variety_card_screen.dart';
import 'package:pristine_seeds/view/IPT/ipt_view_card_screen.dart';
import 'package:pristine_seeds/view/check_in/check_in_screen.dart';
import 'package:pristine_seeds/view/check_out/add_expanse_screen.dart';
import 'package:pristine_seeds/view/check_out/check_out.dart';
import 'package:pristine_seeds/view/event_management/create_event_mng_screen.dart';
import 'package:pristine_seeds/view/forget_password/forgot_password_screen.dart';
import 'package:pristine_seeds/view/home_view/home_pge_screen.dart';
import 'package:pristine_seeds/view/inspection/offline_inspection/inspection_lot_field_detial.dart';
import 'package:pristine_seeds/view/inspection/online_inspection/online_inspection_lot_field_detial.dart';
import 'package:pristine_seeds/view/inspection/online_inspection/online_lot_detail_screen.dart';
import 'package:pristine_seeds/view/login_view/login_screen.dart';
import 'package:pristine_seeds/view/orders/approver_view_card.dart';
import 'package:pristine_seeds/view/orders/new_order_screen.dart';
import 'package:pristine_seeds/view/orders/order_approver_screen.dart';
import 'package:pristine_seeds/view/orders/order_item_category_screen.dart';
import 'package:pristine_seeds/view/orders/order_item_varieties_screen.dart';
import 'package:pristine_seeds/view/orders/order_item_variety_card_screen.dart';
import 'package:pristine_seeds/view/orders/orders_screen.dart';
import 'package:pristine_seeds/view/orders/view_cart_screen.dart';
import 'package:pristine_seeds/view/planting/add_new_planting_line_screen.dart';
import 'package:pristine_seeds/view/planting/create_planting_header_screen.dart';
import 'package:pristine_seeds/view/planting/planting_line_details.dart';
import 'package:pristine_seeds/view/planting/planting_list_screen.dart';
import 'package:pristine_seeds/view/product_on_ground_approved/product_on_ground_approve_screen.dart';

import 'package:pristine_seeds/view/register_view/register_screen.dart';
import 'package:pristine_seeds/view/shipped_order/shipped_order_header_screen.dart';
import 'package:pristine_seeds/view/show_route/show_route_screen.dart';
import 'package:pristine_seeds/view/splash_view/splash_screen.dart';
import 'package:pristine_seeds/view/user_expense/expense_approver.dart';
import 'package:pristine_seeds/view/user_expense/expense_approver_header_view.dart';
import 'package:pristine_seeds/view/user_expense/expenses_screen.dart';
import 'package:pristine_seeds/view/user_expense/my_expenses_screen.dart';

import '../../collection/collection_add_line.dart';
import '../../collection/collection_screen.dart';
import '../../view/IPT/ipt_approver_screen.dart';
import '../../view/IPT/new_ipt_create.dart';
import '../../view/check_in_approver/check_in_approver_header_view.dart';
import '../../view/check_in_approver/check_in_approver_list.dart';
import '../../view/create_password/create_password.dart';

import '../../view/customer_request/customer_request_approver_screen.dart';
import '../../view/customer_request/customer_request_create_screen.dart';
import '../../view/customer_request/customer_request_list_screen.dart';
import '../../view/event_management/approval_header_line_view.dart';
import '../../view/event_management/event_approval_screen.dart';
import '../../view/event_management/event_line_detail.dart';

import '../../view/customer/customer_list.dart';
import '../../view/customer/customer_list_details.dart';

import '../../view/event_management/event_mng_get_list.dart';
import '../../view/inspection/offline_inspection/lot_detail_screen.dart';
import '../../view/inspection/offline_inspection/offline_inspection.dart';
import '../../view/inspection/online_inspection/online_inspaction.dart';
import '../../view/planting/add_geo_location_with_map.dart';

import '../../view/product_on_ground/pog_add_line.dart';
import '../../view/product_on_ground/product_on_ground_screen.dart';

import '../../view/seed_dispatch/create_seed_dispatch_header.dart';
import '../../view/seed_dispatch/create_seed_dispatch_line_screen.dart';
import '../../view/seed_dispatch/seed_dispatch_line_detail.dart';
import '../../view/seed_dispatch/seed_dispatch_list_screen.dart';

import '../../view/shipped_order/shipped_order_screen.dart';
import '../../view/user_expense/create_expenses_screen.dart';

class AppRoutes{
  static appRoutes()=>[
    GetPage(
        name: RoutesName.splashScreen,
        page: ()=>SplashScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.loginScreen,
        page: ()=>LoginScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.registerScreen,
        page: ()=>RegisterScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.forgotPasswordScreen,
        page: ()=>ForgotPassword(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.createPasswordScreen,
        page: ()=>CraetePasswordScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.leftToRight
    ),
    GetPage(name: RoutesName.homeScreen,
        page: ()=>HomePageScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.checkInScreen,
        page: ()=>CheckInScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.checkOutScreen,
        page: ()=>CheckOutScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.addExpanseScreen,
        page: ()=>AddExpanseScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.checkInApproverScreen,
        page: ()=>CheckInApproverScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.checkInApproverHeaderViewScreen,
        page: ()=>CheckInApproverHeaderView(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.userRoutesScreen,
        page: ()=>ShowRoutesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.myExpensesScreen,
        page: ()=>MyExpensesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.createExpensesScreen,
        page: ()=>CreateExpensesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.expanseApproverScreen,
        page: ()=>ExpenseApproverScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.expanseApproverHeaderViewScreen,
        page: ()=>ExpenseApproverHeaderView(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.expensesScreen,
        page: ()=>ExpensesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.ordersScreen,
        page: ()=>OrdersScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.viewCartScreen,
        page: ()=>ViewCartScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.newOrderScreen,
        page: ()=>NewOrderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),

    GetPage(name: RoutesName.orderItemCategoryScreen,
        page: ()=>OrderItemCategoryScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.orderItemVarietiesScreen,
        page: ()=>OrderItemVarietiesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.orderItemVarietyCardScreen,
        page: ()=>OrderItemVarietyCardScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.orderApproverScreen,
        page: ()=>OrderApproverScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.approverCardView,
        page: ()=>ApproverViewCartScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.planting_list,
        page: ()=>PlantingListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.create_planting_header,
        page: ()=>CreatePlantingHeaderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.planting_line_detaile,
        page: ()=>PlantingLineDetailsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.add_new_palnting_line_screen,
        page: ()=>AddNewPlantingLineScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.add_geo_location_with_map,
        page: ()=>AddGeoLocationWithMapScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.onlineInspaction,
        page: ()=>OnlineInspaction(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.onlineLotDetailScreen,
        page: ()=>OnlineLotDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.onlineLotDetailScreen,
        page: ()=>OnlineLotDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.onlineInspectionLotFieldDetailScreen,
        page: ()=>OnlineInspectionLotFieldDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),

    GetPage(name: RoutesName.offlineInspection,
        page: ()=>OfflineInspection(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.lotDetailScreen,
        page: ()=>LotDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.inspectionLotFieldDetailScreen,
        page: ()=>InspectionLotFieldDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.collectionScreen,
        page: ()=>CollectionListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.collectionCreate,
        page: ()=>CollectionAddLineDetails(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),

    GetPage(name: RoutesName.productongroundScreen,
        page: ()=>ProductOnGroundScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.productOnGroundLineDetails,
        page: ()=>POGAddLineDetails(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.productOnGroundApproval,
        page: ()=>ProductOnGroundApprovalScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),



    GetPage(name: RoutesName.customerList,
        page: ()=>CustomerList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.customerListDetails,
        page: ()=>CustomerListDetail(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.seedDispatchList,
        page: ()=>SeedDispatchListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.seedDispatchHeaderCreate,
        page: ()=>CreateSeedDispatchHeaderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.seedDispatchLineCreate,
        page: ()=>AddNewSeedDispatchLineScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.seedDispatchLineDetail,
        page: ()=>SeedDispatchLineDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.eventMngGetList,
        page: ()=>EventManagementListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.createEventMng,
        page: ()=>CreateEventManagement(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),

    GetPage(name: RoutesName.eventLineDetail,
        page: ()=>EventLineDetails(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.eventApproval,
        page: ()=>EventApprovalScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),
    GetPage(name: RoutesName.eventAprovalHeaderLineDetail,
        page: ()=>EventApproveHeaderLineDetails(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),

    GetPage(name: RoutesName.eventAprovalHeaderLineDetail,
        page: ()=>CustomerRequestCreate(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),

    GetPage(name: RoutesName.customerRequestList,
        page: ()=>CustomerRequestList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),

    GetPage(name: RoutesName.customerRequestCreate,
        page: ()=>CustomerRequestCreate(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),


    GetPage(name: RoutesName.customerRequestApproverList,
        page: ()=>CustomerRequestApproverScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),





    GetPage(name: RoutesName.iptHeaderList,
        page: ()=>IptHeaderList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//orderApproverScreen
    ),


    GetPage(name: RoutesName.iptHeaderCreate,
        page: ()=>IptHeaderCreate(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),


    GetPage(name: RoutesName.iptItemCategoryGet,
        page: ()=>IptItemCategory(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),



    GetPage(name: RoutesName.iptItemVerietyGetDetails,
        page: ()=>IptItemVarietiesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),

    GetPage(name: RoutesName.iptItemVerietyCardDetails,
        page: ()=>IptItemVarietyCardScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),

    GetPage(name: RoutesName.iptViewCartScreen,
        page: ()=>IptViewCartScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),


    GetPage(name: RoutesName.iptApproverScreen,
        page: ()=>IptApproverScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),

    GetPage(name: RoutesName.iptApproverviewScreen,
        page: ()=>IptApproverViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),

    GetPage(name: RoutesName.shippedOrderScreen,
        page: ()=>ShippedOrderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),


    GetPage(name: RoutesName.shippedOrderHeaderScreen,
        page: ()=>ShippedOrderHeaderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade//addNewConsigneeScreen
    ),





  ];
}