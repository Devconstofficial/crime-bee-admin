class NotificationSettingsModel {
  bool crimeUpdates = false;
  bool communityActivity = false;
  bool highRiskAreaAlert = false;
  bool adminUpdates = false;

  NotificationSettingsModel.empty();

  NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    crimeUpdates = json["crimeUpdates"] ?? crimeUpdates;
    communityActivity = json["communityActivity"] ?? communityActivity;
    highRiskAreaAlert = json["highRiskAreaAlert"] ?? highRiskAreaAlert;
    adminUpdates = json["adminUpdates"] ?? adminUpdates;
  }

  NotificationSettingsModel copyWith({
    bool? crimeUpdates,
    bool? communityActivity,
    bool? highRiskAreaAlert,
    bool? adminUpdates,
  }) {
    return NotificationSettingsModel.empty()
      ..crimeUpdates=crimeUpdates ?? this.crimeUpdates
      ..communityActivity=communityActivity ?? this.communityActivity
      ..highRiskAreaAlert=highRiskAreaAlert ?? this.highRiskAreaAlert
      ..adminUpdates=adminUpdates ?? this.adminUpdates;
  }

  Map<String, dynamic> toJson() {
    return {
      "crimeUpdates": crimeUpdates,
      "communityActivity": communityActivity,
      "highRiskAreaAlert": highRiskAreaAlert,
      "adminUpdates": adminUpdates
    };
  }

  @override
  String toString() {
    return 'NotificationSettingsModel{crimeUpdates: $crimeUpdates, communityActivity: $communityActivity, highRiskAreaAlert: $highRiskAreaAlert, adminUpdates: $adminUpdates}';
  }
}
