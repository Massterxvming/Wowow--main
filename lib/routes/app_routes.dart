import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/pages/home/add_friend/binding.dart';
import 'package:wowowwish/pages/home/add_friend/view.dart';
import 'package:wowowwish/pages/home/terms/binding.dart';
import 'package:wowowwish/pages/home/terms/view.dart';
import 'package:wowowwish/pages/home/user/block_user_list/binding.dart';
import 'package:wowowwish/pages/home/user/block_user_list/view.dart';
import 'package:wowowwish/pages/home/user/edit_pages/account_delete/binding.dart';
import 'package:wowowwish/pages/home/user/edit_pages/account_delete/view.dart';
import 'package:wowowwish/pages/home/user/edit_pages/edit_password/binding.dart';
import 'package:wowowwish/pages/home/user/edit_pages/edit_password/view.dart';
import 'package:wowowwish/pages/home/user/edit_pages/edit_portrait/binding.dart';
import 'package:wowowwish/pages/home/user/edit_pages/edit_portrait/view.dart';
import 'package:wowowwish/pages/home/user/edit_pages/edit_username/binding.dart';
import 'package:wowowwish/pages/home/user/edit_pages/setting/binding.dart';
import 'package:wowowwish/pages/home/user/others/privacy/binding.dart';
import 'package:wowowwish/pages/home/user/others/privacy/view.dart';
import 'package:wowowwish/pages/home/user/others/system_setting/view.dart';
import 'package:wowowwish/pages/home/user/reminder/over_date_reminder/binding.dart';
import 'package:wowowwish/pages/home/user/reminder/over_date_reminder/view.dart';
import 'package:wowowwish/pages/home/wish/page_wish/want/binding.dart';
import 'package:wowowwish/pages/home/wish/page_wish/want/view.dart';
import 'package:wowowwish/pages/home/wish/page_wish/wish_share/binding.dart';
import 'package:wowowwish/pages/home/wish/page_wish/wish_share/view.dart';
import 'package:wowowwish/pages/home/wish/page_wish/wish_share_simple/binding.dart';
import 'package:wowowwish/pages/home/wish/page_wish/wish_share_simple/view.dart';
import 'package:wowowwish/pages/home/wish_to/binding.dart';
import 'package:wowowwish/pages/home/wish_to/view.dart';
import 'package:wowowwish/pages/login/binding.dart';
import 'package:wowowwish/pages/login/forget/binding.dart';
import 'package:wowowwish/pages/login/forget/reset_password/binding.dart';
import 'package:wowowwish/pages/login/forget/reset_password/view.dart';
import 'package:wowowwish/pages/login/forget/view.dart';
import 'package:wowowwish/pages/login/set_password/binding.dart';
import 'package:wowowwish/pages/login/set_password/view.dart';
import 'package:wowowwish/pages/login/sign_up/binding.dart';
import 'package:wowowwish/pages/login/sign_up/view.dart';
import 'package:wowowwish/pages/login/view.dart';
import 'package:wowowwish/pages/splash/binding.dart';
import 'package:wowowwish/pages/splash/guide_page/binding.dart';
import 'package:wowowwish/pages/splash/guide_page/view.dart';
import '../pages/home/binding.dart';
import '../pages/home/user/edit_pages/edit_username/view.dart';

import '../pages/home/user/reminder/binding.dart';
import '../pages/home/user/reminder/view.dart';
import '../pages/home/user/wanna_list/binding.dart';
import '../pages/home/user/wanna_list/view.dart';
import '../pages/home/view.dart';
import '../pages/splash/view.dart';



abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => SplashPage(),binding: SplashBinding()),
    GetPage(name: Routes.SETPASSWORD, page: () => SetPasswordPage(),binding: SetPasswordBinding()),
    GetPage(name: Routes.GUIDE, page: () => GuidePagePage(),binding: GuidePageBinding()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.RESETPASSWORD, page: () => ResetPasswordPage(), binding: ResetPasswordBinding()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.EDITUSERNAME, page: () =>EditUsernamePage(), binding: EditUsernameBinding()),
    GetPage(name: Routes.EDITPASSWORD, page: () =>EditPasswordPage(), binding: EditPasswordBinding()),
    GetPage(name: Routes.ADDFRIEND, page: () =>AddFriendPage(), binding: AddFriendBinding()),
    GetPage(name: Routes.SIGNUP, page: () =>SignUpPage(), binding: SignUpBinding()),
    GetPage(name: Routes.WISHTO, page: () =>WishToPage(), binding: WishToBinding()),
    GetPage(name: Routes.WANT, page: () =>WantPage(), binding: WantBinding()),
    GetPage(name: Routes.WISHSHARESIMPLE, page: () =>WishSharePageSimple(), binding: WishShareSimpleBinding()),
    GetPage(name: Routes.TERMS, page: () =>TermsPage(), binding: TermsBinding()),
    GetPage(name: Routes.FORGET, page: () =>ForgetPage(), binding: ForgetBinding()),
    GetPage(name: Routes.PORTRAIT, page: () =>EditPortraitPage(), binding: EditPortraitBinding()),
    GetPage(name: Routes.REMINDER, page: () =>ReminderPage(), binding: ReminderBinding()),
    GetPage(name: Routes.SETTING, page: () =>SystemSettingPage(), binding: SettingBinding()),
    GetPage(name: Routes.OVERDATEREMINDER, page: () =>OverDateReminderPage(), binding: OverDateReminderBinding()),
    GetPage(name: Routes.WANNALIST, page: () =>WannaListPage(), binding: WannaListBinding()),
    GetPage(name: Routes.PRIVACY, page: () =>PrivacyPage(), binding: PrivacyBinding()),
    GetPage(name: Routes.BLOCKUSERLIST, page: () =>BlockUserListPage(), binding: BlockUserListBinding()),
    GetPage(name: Routes.WISHSHARE, page: () =>WishSharePage(), binding: WishShareBinding()),
    GetPage(name: Routes.ACCOUNTDELETE, page: () =>AccountDeletePage(), binding: AccountDeleteBinding()),
    GetPage(name: Routes.JUDGE, page: (){
      return boxAccount.hasData('token')?HomePage():LoginPage();
    } ,),
    GetPage(name: Routes.INITIAL, page: () {
      // boxAccount.erase();
      // box.erase();
      // boxFlag.erase();
      if(boxFlag.read('isFirstTime')==null){
        boxFlag.write('isFirstTime', true);
      }
      return const SplashPage();})
  ];
}

abstract class Routes {
  static const INITIAL = '/';
  static const BLOCKUSERLIST = '/block_user_list';
  static const RESETPASSWORD = '/reset_password';
  static const OVERDATEREMINDER = '/over_date_reminder';
  static const FORGET = '/forget';
  static const ADDFRIEND = '/add/friend';
  static const EDITUSERNAME = '/edit/username';
  static const EDITPASSWORD = '/edit/password';
  static const SIGNUP = '/sign_up';
  static const WISHTO = '/wish_to';
  static const WANT = '/want';
  static const PORTRAIT = '/portrait';
  static const JUDGE = '/judge';
  static const PRIVACY = '/privacy';
  static const SETPASSWORD = '/set_password';
  static const WANNALIST = '/wanna_list';
  static const WISHSHARE = '/wish_share';
  static const WISHSHARESIMPLE = '/wish_share_simple';

  //闪屏页
  static const SPLASH = '/splash';
  static const TERMS = '/terms';
  static const SETTING = '/setting';
  static const GUIDE = '/guide';
  // static const DELETEPOSTLIST = '/delete_post';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REMINDER = '/reminder';
  static const ACCOUNTDELETE = '/account_delete';
}
