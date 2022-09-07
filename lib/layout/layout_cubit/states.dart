abstract class SocialLayoutStates {}
class InitialSocialLayoutState extends SocialLayoutStates {}
class ChangeBottomNavigatorState extends SocialLayoutStates {}

// Get User Data
class LoadingGetUserState extends SocialLayoutStates {}
class SuccessGetUserState extends SocialLayoutStates {}
class ErrorGetUserState extends SocialLayoutStates {
  final String error;
  ErrorGetUserState(this.error);
}

// Picked Image[Profile]
class LoadingPickImageState extends SocialLayoutStates {}
class SuccessPickImageState extends SocialLayoutStates {}
class ErrorPickImageState extends SocialLayoutStates {}

// Picked Cover
class LoadingPickCoverState extends SocialLayoutStates {}
class SuccessPickCoverState extends SocialLayoutStates {}
class ErrorPickCoverState extends SocialLayoutStates {}

// Upload Image[Profile]
class LoadingUploadImageProfileState extends SocialLayoutStates {}
class SuccessUploadImageProfileState extends SocialLayoutStates {}
class ErrorUploadImageProfileState extends SocialLayoutStates {
  final String error;
  ErrorUploadImageProfileState(this.error);
}

// Upload Image[Cover]
class LoadingUploadCoverState extends SocialLayoutStates {}
class SuccessUploadCoverState extends SocialLayoutStates {}
class ErrorUploadCoverState extends SocialLayoutStates {
  final String error;
  ErrorUploadCoverState(this.error);
}


// Update Info
class LoadingUpdateInfoState extends SocialLayoutStates {}
class SuccessUpdateInfoState extends SocialLayoutStates {}
class ErrorUpdateInfoState extends SocialLayoutStates {
  final String error;
  ErrorUpdateInfoState(this.error);
}



// Post
class LoadingPostState extends SocialLayoutStates {}
class SuccessPostState extends SocialLayoutStates {}
class ErrorPostState extends SocialLayoutStates {
  final String error;
  ErrorPostState(this.error);
}

// Get Post
class LoadingGetPostState extends SocialLayoutStates {}
class SuccessGetPostState extends SocialLayoutStates {}
class ErrorGetPostState extends SocialLayoutStates {
  final String error;
  ErrorGetPostState(this.error);
}

// Picked ImagePost
class LoadingPickImagePostState extends SocialLayoutStates {}
class SuccessPickImagePostState extends SocialLayoutStates {}
class ErrorPickImagePostState extends SocialLayoutStates {}

// Remove ImagePost
class SuccessRemoveImageState extends SocialLayoutStates {}

// Upload Image[Post]
class LoadingPostImageState extends SocialLayoutStates {}
class SuccessPostImageState extends SocialLayoutStates {}
class ErrorPostImageState extends SocialLayoutStates {
  final String error;
  ErrorPostImageState(this.error);
}


// Get All User
class LoadingGetAllUserState extends SocialLayoutStates {}
class SuccessGetAllUserState extends SocialLayoutStates {}
class ErrorGetAllUserState extends SocialLayoutStates {
  final String error;
  ErrorGetAllUserState(this.error);
}


// Send Messages
class LoadingSendMessagesState extends SocialLayoutStates {}
class SuccessSendMessagesState extends SocialLayoutStates {}
class ErrorSendMessagesState extends SocialLayoutStates {
  final String error;
  ErrorSendMessagesState(this.error);
}


// Get Messages
class LoadingGetMessagesState extends SocialLayoutStates {}
class SuccessGetMessagesState extends SocialLayoutStates {}
class ErrorGetMessagesState extends SocialLayoutStates {
  final String error;
  ErrorGetMessagesState(this.error);
}


// Send Like
class LoadingSendLikeState extends SocialLayoutStates {}
class SuccessSendLikeState extends SocialLayoutStates {}
class ErrorSendLikeState extends SocialLayoutStates {
  final String error;
  ErrorSendLikeState(this.error);
}

