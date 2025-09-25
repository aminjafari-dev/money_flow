// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'جریان پول';

  @override
  String get dashboard => 'داشبورد';

  @override
  String get transactions => 'تراکنش‌ها';

  @override
  String get analytics => 'تحلیل‌ها';

  @override
  String get settings => 'تنظیمات';

  @override
  String get addTransaction => 'افزودن تراکنش';

  @override
  String get editTransaction => 'ویرایش تراکنش';

  @override
  String get login => 'ورود';

  @override
  String get splash => 'صفحه شروع';

  @override
  String get welcomeToDashboard => 'به داشبورد خود خوش آمدید!';

  @override
  String get somethingWentWrong => 'مشکلی پیش آمد';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get settingsComingSoon => 'تنظیمات به زودی!';

  @override
  String get addTransactionComingSoon => 'افزودن تراکنش به زودی!';

  @override
  String get refresh => 'بروزرسانی';

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String get error => 'خطا';

  @override
  String get success => 'موفقیت';

  @override
  String get cancel => 'لغو';

  @override
  String get save => 'ذخیره';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'ویرایش';

  @override
  String get add => 'افزودن';

  @override
  String get close => 'بستن';

  @override
  String get back => 'بازگشت';

  @override
  String get next => 'بعدی';

  @override
  String get previous => 'قبلی';

  @override
  String get done => 'تمام';

  @override
  String get confirm => 'تأیید';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get ok => 'باشه';

  @override
  String get noData => 'هیچ داده‌ای موجود نیست';

  @override
  String get tryAgain => 'تلاش مجدد';

  @override
  String get networkError => 'خطای شبکه. لطفاً اتصال خود را بررسی کنید.';

  @override
  String get serverError => 'خطای سرور. لطفاً بعداً تلاش کنید.';

  @override
  String get unknownError => 'خطای ناشناخته‌ای رخ داد.';

  @override
  String get totalBalance => 'موجودی کل';

  @override
  String get monthlyIncome => 'درآمد ماهانه';

  @override
  String get monthlyExpenses => 'هزینه‌های ماهانه';

  @override
  String get recentTransactions => 'تراکنش‌های اخیر';

  @override
  String get viewAll => 'مشاهده همه';

  @override
  String get income => 'درآمد';

  @override
  String get expense => 'هزینه';

  @override
  String get investment => 'سرمایه‌گذاری';

  @override
  String get charity => 'خیریه';

  @override
  String get amount => 'مبلغ';

  @override
  String get category => 'دسته‌بندی';

  @override
  String get description => 'توضیحات';

  @override
  String get date => 'تاریخ';

  @override
  String get time => 'زمان';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get addTransactionPageTitle => 'افزودن تراکنش';

  @override
  String get subcategoryOptional => 'زیردسته (اختیاری)';

  @override
  String get dateTime => 'تاریخ و زمان';

  @override
  String get merchant => 'فروشنده';

  @override
  String get loadingCategories => 'در حال بارگذاری دسته‌بندی‌ها...';

  @override
  String get loadingSubcategories => 'در حال بارگذاری زیردسته‌ها...';

  @override
  String get noCategoriesAvailable => 'هیچ دسته‌بندی موجود نیست';

  @override
  String get noSubcategoriesAvailable => 'هیچ زیردسته‌ای موجود نیست';

  @override
  String get transactionAddedSuccessfully => 'تراکنش با موفقیت اضافه شد!';

  @override
  String get amountCannotBeZero => 'مبلغ نمی‌تواند صفر باشد';

  @override
  String get pleaseSelectCategory => 'لطفاً یک دسته‌بندی انتخاب کنید';

  @override
  String get tapToEditAmount => 'برای ویرایش مبلغ ضربه بزنید';

  @override
  String get enterAmountAndTapOutsideToConfirm =>
      'مبلغ را وارد کنید و برای تأیید بیرون ضربه بزنید';

  @override
  String get enterDescription => 'توضیحات را وارد کنید';

  @override
  String get selectDateTime => 'تاریخ و زمان را انتخاب کنید';

  @override
  String get updateTransaction => 'بروزرسانی تراکنش';

  @override
  String get financialOverview => 'نمای کلی مالی';

  @override
  String get receivedThisMonth => 'دریافتی این ماه';

  @override
  String get spentThisMonth => 'خرج شده این ماه';

  @override
  String get donatedThisMonth => 'اهدایی این ماه';

  @override
  String get currentValue => 'ارزش فعلی';

  @override
  String get noTransactionsYet => 'هنوز تراکنشی وجود ندارد';

  @override
  String get recentTransactionsWillAppear =>
      'تراکنش‌های اخیر شما اینجا نمایش داده خواهد شد';

  @override
  String get smsImport => 'وارد کردن پیامک';

  @override
  String get smsMessages => 'پیام‌های پیامک';

  @override
  String permissionError(Object message) {
    return 'خطای مجوز: $message';
  }

  @override
  String get pleaseEnableSmsPermissionInSettings =>
      'لطفاً مجوز پیامک را در تنظیمات فعال کنید';

  @override
  String get initializingSmsImport => 'در حال راه‌اندازی وارد کردن پیامک...';

  @override
  String get checkingSmsPermission => 'در حال بررسی مجوز پیامک...';

  @override
  String get requestingSmsPermission => 'در حال درخواست مجوز پیامک...';

  @override
  String get loadingSmsConversations => 'در حال بارگذاری مکالمات پیامک...';

  @override
  String get loadingSmsMessages => 'در حال بارگذاری پیام‌های پیامک...';

  @override
  String get loadingMoreConversations => 'در حال بارگذاری مکالمات بیشتر...';

  @override
  String get noConversationsLoaded => 'هیچ مکالمه‌ای بارگذاری نشده';

  @override
  String get tapRefreshToLoadSmsConversations =>
      'برای بارگذاری مکالمات پیامک، بروزرسانی را لمس کنید';

  @override
  String get loadConversations => 'بارگذاری مکالمات';

  @override
  String get noSmsConversationsFound => 'هیچ مکالمه پیامکی یافت نشد';

  @override
  String get makeSureYouHaveSmsMessagesOnYourDevice =>
      'مطمئن شوید که پیام‌های پیامک در دستگاه شما وجود دارد';

  @override
  String get errorLoadingConversations => 'خطا در بارگذاری مکالمات';

  @override
  String get noMessagesLoaded => 'هیچ پیامی بارگذاری نشده';

  @override
  String get tapRefreshToLoadSmsMessages =>
      'برای بارگذاری پیام‌های پیامک، بروزرسانی را لمس کنید';

  @override
  String get loadMessages => 'بارگذاری پیام‌ها';

  @override
  String get noSmsMessagesFound => 'هیچ پیام پیامکی یافت نشد';

  @override
  String get makeSureYouHaveSmsMessagesFromThisSender =>
      'مطمئن شوید که پیام‌های پیامک از این فرستنده وجود دارد';

  @override
  String get errorLoadingMessages => 'خطا در بارگذاری پیام‌ها';

  @override
  String get messages => 'پیام‌ها';

  @override
  String get day => 'روز';

  @override
  String get days => 'روز';

  @override
  String get hour => 'ساعت';

  @override
  String get hours => 'ساعت';

  @override
  String get minute => 'دقیقه';

  @override
  String get minutes => 'دقیقه';

  @override
  String get ago => 'پیش';

  @override
  String get justNow => 'همین الان';

  @override
  String get yesterday => 'دیروز';

  @override
  String get read => 'خوانده شده';

  @override
  String get unread => 'خوانده نشده';

  @override
  String get smsPermissionRequired => 'مجوز پیامک مورد نیاز است';

  @override
  String get toImportSmsMessagesWeNeedPermission =>
      'برای وارد کردن پیام‌های پیامک، به مجوز خواندن پیامک شما نیاز داریم. لطفاً مجوز پیامک را در تنظیمات دستگاه خود فعال کنید.';

  @override
  String get openSettings => 'باز کردن تنظیمات';
}
