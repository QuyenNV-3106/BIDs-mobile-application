import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

const apiUrl = "https://bids-online.azurewebsites.net";

const signalRSessionHub = "/sessionhub";
const signalRSessionDetailHub = "/sessiondetailhub";
const signalRUserHub = "/userhub";

const apiLogin = "/api/Login/login";
const apiPaymentToRegister = "/api/Login/payment_joinning";
const apiPaymentComplete = "/api/Login/payment_complete";
const apiRejectPayment = "/api/Sessions/reject_payment";
const apiUserProfile = "/api/Users/by_email";
const apiLoginDecrypttoken = "/api/Login/Login";
const apiGetCategories = "/api/Categorys";
const apiGetSessions = "/api/Sessions";
const apiGetSessionsHaveNotPay =
    "/api/Sessions/by_havent_tranfer_by_auctioneer?userId=";
const apiGetSessionsNotStart = "/api/Sessions/by_not_start";
const apiGetSessionsInStage = "/api/Sessions/by_in_stage";
const apiGetSessionsCheckAndUpdateOrder =
    "/api/Sessions/check_and_update_order";
const apiGetSessionDetail = "/api/SessionDetails/by_session";
const apiGetSessionDetailWinner = "/api/SessionDetails/winner?sessionId=";
const apiGetItem = "/api/Items";
const apiItemDescriptions = "/api/ItemDescriptions";
const apiItemImages = "/api/Images";
const apiResetPassword = "/api/Login/reset_password";
const apiPostAccount = "/api/Users";
const apiPostPayment = "/api/UserPaymentInformation";
const apiPutPayment = "/api/UserPaymentInformation";
const apiPutAccount = "/api/Users";
const apiConfirmEmailUser = "/api/Users/confirm_email?email=";
const apiUpdateRoleUser = "/api/Users/update_role_user";
const apiFee = "/api/Fee";
const apiBidding = "/api/SessionDetails/increase_price";
const apiJoinning = "/api/SessionDetails/joinning";
const apiJoinningInStage = "/api/SessionDetails/joinning_in_stage";
const apiBookingItemWaitting = "/api/BookingItems/by_user_watting?id=";
const apiBookingItemAccepted = "/api/BookingItems/by_user_accepted?id=";
const apiBookingItemDenied = "/api/BookingItems/by_user_denied?id=";
const apiBookingItemWaittingCreateSession =
    "/api/BookingItems/by_user_waiting_create_session?id=";
const apiSessionCompleteByUser = "/api/Sessions/by_complete_by_winner?userId=";
const apiSessionSuccess = "/api/Sessions/by_complete_by_auctioneer?userId=";
const apiSessionFailByUser = "/api/Sessions/by_fail_by_auctioneer?userId=";
const apiSessionInStageByUser = "/api/Sessions/by_in_stage_by_auctioneer?id=";
const apiSessionReceivedByUser =
    "/api/Sessions/by_received_by_auctioneer?userId=";
const apiSessionErrorByUser =
    "/api/Sessions/by_error_item_by_auctioneer?userId=";

const signalRIncreasePriceDetailMethod = "ReceiveSessionDetailAdd";
const signalRIncreasePriceSessionMethod = "ReceiveSessionUpdate";
const signalRUserUpdatedMethod = "ReceiveUserUpdate";

const testFrontPathImage = "/test/front";
const testBackPathImage = "/test/back";

const String logo = "assets/images/logo_2.png";
const String noImage = "assets/images/no-image-icon-6.png";

const kTextColor = Color(0xFF757575);
const kPrimaryColor = Color(0xFFFF7643);
const kLoading = Color.fromRGBO(255, 255, 255, 0.5);
const kLoadingRes = Color.fromRGBO(255, 255, 255, 1);

Size sizeInit(BuildContext context) {
  return MediaQuery.of(context).size;
}

const spinkit = SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50,
);

// Validate
NumberFormat regexCurrency = NumberFormat("#,##0", "vi_VN");
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidationRegExp = RegExp(r'^(0[0-9]{9})$');
final RegExp cccdRegExp = RegExp(r'^[0-9]{12}$');
final RegExp capiVN = RegExp(
    r'\b\S*[AĂÂÁẮẤÀẰẦẢẲẨÃẴẪẠẶẬĐEÊÉẾÈỀẺỂẼỄẸỆIÍÌỈĨỊOÔƠÓỐỚÒỒỜỎỔỞÕỖỠỌỘỢUƯÚỨÙỪỦỬŨỮỤỰYÝỲỶỸỴAĂÂÁẮẤÀẰẦẢẲẨÃẴẪẠẶẬĐEÊÉẾÈỀẺỂẼỄẸỆIÍÌỈĨỊOÔƠÓỐỚÒỒỜỎỔỞÕỖỠỌỘỢUƯÚỨÙỪỦỬŨỮỤỰYÝỲỶỸỴAĂÂÁẮẤÀẰẦẢẲẨÃẴẪẠẶẬĐEÊÉẾÈỀẺỂẼỄẸỆIÍÌỈĨỊOÔƠÓỐỚÒỒỜỎỔỞÕỖỠỌỘỢUƯÚỨÙỪỦỬŨỮỤỰYÝỲỶỸỴAĂÂÁẮẤÀẰẦẢẲẨÃẴẪẠẶẬĐEÊÉẾÈỀẺỂẼỄẸỆIÍÌỈĨỊOÔƠÓỐỚÒỒỜỎỔỞÕỖỠỌỘỢUƯÚỨÙỪỦỬŨỮỤỰYÝỲỶỸỴAĂÂÁẮẤÀẰẦẢẲẨÃẴẪẠẶẬĐEÊÉẾÈỀẺỂẼỄẸỆIÍÌỈĨỊOÔƠÓỐỚÒỒỜỎỔỞÕỖỠỌỘỢUƯÚỨÙỪỦỬŨỮỤỰYÝỲỶỸỴAĂÂÁẮẤÀẰẦẢẲẨÃẴẪẠẶẬĐEÊÉẾÈỀẺỂẼỄẸỆIÍÌỈĨỊOÔƠÓỐỚÒỒỜỎỔỞÕỖỠỌỘỢUƯÚỨÙỪỦỬŨỮỤỰYÝỲỶỸỴA-Z]+\S*\b');

const String emailNullError = "Bạn chưa nhập email";
const String invalidEmailError = "Email không hợp lệ";
const String cccdNullError = "Bạn chưa nhập CCCD";
const String invalidcccdError = "Số CCCD không hợp lệ";
const String invalidPhoneError = "Số điện thoại không hợp lệ";
const String passNullError = "Bạn chưa nhập mật khẩu";
const String shortPassError = "Mật khẩu tối thiểu là 8 kí tự";
const String matchPassError = "Mật khẩu chưa trùng khớp";
const String namelNullError = "Bạn chưa nhập tên tài khoản";
const String descriptionlNullError = "Bạn chưa nhập chi tiết";
const String nameItemlNullError = "Bạn chưa nhập tên sản phẩm";
const String qualitylNullError = "Bạn chưa nhập số lượng";
const String qualityError = "Số lượng phải lớn hơn 0";
const String stepPriceError = "Bước giá (5-10% giá ban đầu)";
const String stepPriceNullError = "Bạn chưa nhập bước giá";
const String priceError = "Giá ban đầu phải lớn hơn 1.000.000 VNĐ";
const String priceNullError = "Bạn chưa nhập giá khởi điểm";
const String timeError = "Thời gian phải lớn hơn 0";
const String timeNullError = "Bạn chưa nhập thời gian";
const String doblNullError = "Bạn chưa nhập ngày sinh";
const String phoneNumberNullError = "Bạn chưa nhập số điện thoại";
const String addressNullError = "Bạn chưa nhập địa chỉ";

const loadingLoginState = "Đang đăng nhập";
const loadingHomeState = "Hệ thống đang nạp tài nguyên";
const loadingLoginSuccessState = "Đăng nhập thành công\n$loadingHomeState";

const messageRegister =
    "Bạn đã tham gia vào cuộc đấu giá này trước đó, vui lòng kiểm tra lại email để nắm bắt thông tin của cuộc đấu giá.";
const messageInStage =
    "Bạn vui lòng thanh toán phí tham gia và phí đặt cọc(Nếu có) để có thể tham gia vào phiên đấu giá này. Sau khi thanh toán xong vui lòng nhấn đăng ký hoặc tăng giá thêm 1 lần để hoàn tất.";
