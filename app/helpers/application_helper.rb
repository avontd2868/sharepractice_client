module ApplicationHelper
  
  include HTTParty
  base_uri ENV["API_RESOURCE_URL"]

  # kSPAuthenticationKey = "kSPAuthenticationKey";
  # kSPUsername = @"kSPUsername";
  # kSPUserFuleName = @"kSPUserFuleName";
  # kSPUserSpecialty = @"kSPUserSpecialty";
  # kSPUserLocation = @"kSPUserLocation";
  # kSPUserUrl = @"kSPUserUrl";
  # kSPUserId = @"kSPUserId";
  # kSPLoginURL = @"/api/v1/tokens?format=json";
  # kSPRegisterURL = @"/api/v1/users/?format=json";
  # kSPRequestInviteURL = @"/api/v1/users/invite";
  # kSPForgotPasswordURL = @"/api/v1/users/forgotpw";
  # kSPUserDetailsURL = @"/api/v1/users/%@/?format=json";

  # kSPUserFollowingURL = @"/api/v1/colleagues/following/?user_id=%@&format=json";
  # kSPUserFollowersURL = @"/api/v1/colleagues/followers/?user_id=%@&format=json";
  # kSPUserFollowURL = @"/api/v1/colleagues/?format=json";
  # kSPUserUnFollowURL = @"/api/v1/colleagues/%@/?format=json";
  # kSPUserActivityURL = @"api/v1/users/activity?format=json";

  # kSPSetUserDetailsURL = @"/api/v1/users/%@/?format=json"; // TODO
  # kSPSearchDisorderURL = @"/api/v1/disorders/search";
  # kSPSearchTreatmentURL = @"/api/v1/treatments/search";
  # kSPDisordersURL = @"/api/v1/disorders/%@/";
  # kSPTreatmentsURL = @"/api/v1/treatments/%@/"; // TODO
  # kSPPrescriptionURL = @"/api/v1/prescriptions/%@";
  # kSPPrescriptionCommentsURL = @"/api/v1/prescriptions/%@/comments";
  # kSPPrescriptionAddCommentURL = @"/api/v1/prescriptions/%@/comments";
  # kSPPrescriptionVoteURL = @"/api/v1/prescriptions/%@/votes/%@";
  # kSPPrescriptionUnVoteURL = @"/api/v1/prescriptions/%@/votes/%@";
  # kSPAddSignatureURL = @"/api/v1/prescriptions/";
  # kSPDoximityVerifyURL = @"/api/v1/users/doximity_verify";
end
