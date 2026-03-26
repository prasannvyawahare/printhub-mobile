abstract class BaseRepository {
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
          httpResponse.data,
          message: httpResponse.response.statusMessage,
        );
      } else {
        if (httpResponse.response.statusCode == 503) {
          cvPrint("Chief :::: ${httpResponse.response}");

          final data = httpResponse.response.data;
          final errorCode = data?['ErrorCode'];
          if (errorCode == "1000") {
            DowntimeMaintenanceService().report503Error();
            RealTimeDowntimeSnackbar.hideSnackbarOn503Error();
            showCvUnderMaintenanceDialog();
          }
        }

        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 503) {
        cvPrint(
            'Chief : 2.getStateOf() statusCode = ${error.response?.statusCode}');

        DowntimeMaintenanceService().report503Error();
        RealTimeDowntimeSnackbar.hideSnackbarOn503Error();
        showCvUnderMaintenanceDialog();
      }

      if (error.response?.data != null) {
        final data = error.response!.data;
        try {
          var response = RequestFailed.fromJson(data);
          response.statusCode = response.statusCode ?? response.statusCode1;
          response.error = response.error ?? response.error1;
          response.requestId = response.requestId ?? response.requestId1;
          response.errorCode = response.errorCode ?? response.errorCode1;

          /// Common Response
          return DataFailedWithResponse(response);
        } catch (e) {
          return DataFailedWithoutResponse(error);
        }
      }

      String? errorMessage = error.message;

      if (errorMessage == null && error.error is HttpException) {
        errorMessage = (error.error as HttpException).message;
      }
      return DataFailedWithoutResponse(error);
    } on SocketException catch (error) {
      if (kDebugMode) {
        print(error);
      }

      throw DioException(requestOptions: RequestOptions(baseUrl: ""));
    }
  }

  static void _doReAuthentication() async {
    cvPrint("Chief : getStateOf :: Method called at: ${DateTime.now()}");

    if (CVRuntimeLocalData.isCurrentlyLoggedIn) {
      ReAuthenticationState reAuthenticate =
      await ReAuthenticate.reAuthenticate();
      cvPrint("Chief : getStateOf :: reAuthenticate = $reAuthenticate");

      if (reAuthenticate == ReAuthenticationState.Authorized) {
        dismissCvUnderMaintenanceDialog();

        cvPrint(
            'Chief : getStateOf :: user logged in : cancelled the timer and popped out the dialog!');
      } else if (reAuthenticate == ReAuthenticationState.Unauthorized) {
        /// Dismiss ClearView under maintenance dialog if any...
        dismissCvUnderMaintenanceDialog();

        /// And then show Account settings have changed dialog...
        ReAuthenticate.showAccountSettingsChangedDialog();

        cvPrint(
            'Chief : getStateOf :: user logged in : cancelled the timer and showed account settings changed dialog!');
      }
    } else {
      dismissCvUnderMaintenanceDialog();

      cvPrint(
          'Chief : getStateOf :: user not logged in : cancelled the timer and popped out the dialog!');
    }
  }

  static Timer? _timer;

  static BuildContext? cvUnderMaintenanceDialogContext;

  static void dismissCvUnderMaintenanceDialog() {
    _timer?.cancel();

    if (cvUnderMaintenanceDialogContext != null &&
        cvUnderMaintenanceDialogContext!.mounted) {
      //Navigator.pop(cvUnderMaintenanceDialogContext!);
      cvUnderMaintenanceDialogContext!.pop();

      cvUnderMaintenanceDialogContext = null;
    }

    cvPrint(
        'Chief : Chief : getStateOf :: dismissed cvUnderMaintenanceDialog()!');
  }

  static void showCvUnderMaintenanceDialog() {
    cvPrint(
        'Chief : getStateOf :: showCvUnderMaintenanceDialog()! :: ${DateTime.now()}');

    /// Reset the timer and remove any existing dialogs
    dismissCvUnderMaintenanceDialog();

    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) async {
      cvPrint('Chief : getStateOf :: timer tick = ${timer.tick}');
      _doReAuthentication();
    });

    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        cvUnderMaintenanceDialogContext = context;

        return PopScope(
          canPop: true,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r), // 👈 Radius here
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  CvIcons.cvUnderMaintenanceIcon,
                  width: 102.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  CVPrefetchedLocaliseKeys.weWillBeRightBack ??
                      'We\'ll Be Right Back',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xff35AAD6)
                        : const Color(0xff35AAD6),
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  CVPrefetchedLocaliseKeys.systemUnderMaintenance ??
                      'Our system is temporarily down for maintenance to serve you better. Please check back shortly',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color(0xff848484),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: CvButtonWidget(
                    label: CVPrefetchedLocaliseKeys.ok ?? 'Okay',
                    onPressed: () async {
                      context.pop();;
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}