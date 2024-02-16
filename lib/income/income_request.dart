class IncomeRequestModel {
  String? pfr;
  String? jeu;
  String? nvu;
  String? aof;

  IncomeRequestModel({this.pfr, this.jeu, this.nvu, this.aof});

  IncomeRequestModel.fromJson(Map<String, dynamic> json) {
    pfr = json['pfr'];
    jeu = json['jeu'];
    nvu = json['nvu'];
    aof = json['aof'];
  }
}

class IncomeRequest {
  late bool blvl;
  late IncomeRequestModel incomeRequest;

  IncomeRequest({
    required this.blvl,
    required this.incomeRequest,
  });

  IncomeRequest.fromJson(Map<String, dynamic> json) {
    blvl = json['brs_strt'];
    incomeRequest = IncomeRequestModel.fromJson(json['bk_json']);
  }
}
