import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String url = "192.168.1.11:5000";

class TokenManager {
  static String? _token;
  static String? _role;

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('user_token');
    _role = prefs.getString('user_role');
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('user_token');
    await prefs.remove('user_role');
  }

  static String? get role => _role;

  static String? get token {
    if (_token == null || isTokenExpired()) {
      return null;
    }
    return _token;
  }

  static bool isTokenExpired() {
    if (_token == null) return true;

    try {
      final parts = _token!.split('.');
      if (parts.length != 3) {
        return true;
      }

      final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

      final exp = payload['exp'];
      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expiryDate.isBefore(DateTime.now());
    } catch (e) {
      return true;
    }
  }
}

//auth :
const String loginBaseUrl = '/api/auth/login';
const String registerBaseUrl = '/api/auth/register';
const String forgotPasswordBaseUrl = '/api/auth/forgotPassword';
const String verifyResetCodeBaseUrl = '/api/auth/verifyResetCode';
const String resetPasswordBaseUrl = '/api/auth/resetPassword';
//summary :
const String addOrUpadateSummaryBaseUrl = '/api/summary/createOrUpdate';
const String getSummaryBaseUrl = '/api/summary/summarie';
//work experience :
const String createWorkExperienceUrl = '/api/workexperience/create';
const String getAllWorkExperienceUrl = '/api/workexperience/work-experiences';
const String getSingleWorkExperienceUrl = '/api/workexperience/work-experience';
const String updateWorkExperienceUrl = '/api/workexperience/update';
const String deleteWorkExperienceUrl = '/api/workexperience/delete';
//education :
const String createEducationUrl = '/api/education/create';
const String getAllEducationUrl = '/api/education/educations';
const String getSingleEducationUrl = '/api/education/education';
const String updateEducationUrl = '/api/education/update';
const String deleteEducationUrl = '/api/education/delete';
//project :
const String createProjectUrl = '/api/project/create';
const String getAllProjectUrl = '/api/project/projects';
const String getSingleProjectUrl = '/api/project/project';
const String updateProjectUrl = '/api/project/update';
const String deleteProjectUrl = '/api/project/delete';
//language :
const String createLanguageUrl = '/api/language/create';
const String getAllLanguageUrl = '/api/language/languages';
const String getSingleLanguageUrl = '/api/language/language';
const String updateLanguageUrl = '/api/language/update';
const String deleteLanguageUrl = '/api/language/delete';
//organization :
const String createOrganizationActivityUrl =
    '/api/organization_activity/create';
const String getAllOrganizationActivitiesUrl =
    '/api/organization_activity/activities';
const String getSingleOrganizationActivityUrl =
    '/api/organization_activity/activity';
const String updateOrganizationActivityUrl =
    '/api/organization_activity/update';
const String deleteOrganizationActivityUrl =
    '/api/organization_activity/delete';
//Skills :
const String skillsUrl = '/api/skill/skills';
//Contact info :
const String contactInfoUrl = '/api/contactinfo/contact-info';
//profilHeader :
const String profilHeaderUrl = '/api/users/profil-header';
//companyData
const String companyData = '/api/company/company';
//job offer
const String jobOfferData = '/api/job-offers/job-offers';
//job category
const String jobcategoryData = '/api/job-category/job-category';
//recent job offer
const String recentJobOffer = '/api/job-offers/recent';
//saved jobs
const String savedJob = '/api/saved/saved';
//job apply
const String jobApplyurl = "/api/JobApplication/JobApplication";
//messaging
const String messaging = "/api/chat/chat";
//profil percentage
const String profilPercentage = "/api/profil/CVCompletion";
//filter
const String filterUri = "/api/filter/filter";

const String getRecentApplicantUri = "/api/JobApplication/recent";