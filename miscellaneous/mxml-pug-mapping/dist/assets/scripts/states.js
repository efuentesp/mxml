$(document).ready(function() {
  hideAllStates_AMCmpLoadingAd();
  $("#AMCmpLoadingAd_baseState").show();

  $("#btn_AMCmpLoadingAd_baseState").click(function() {
    hideAllStates_AMCmpLoadingAd();
    $("#AMCmpLoadingAd_baseState").show();
  });

  $("#btn_AMCmpLoadingAd_agrega_5").click(function() {
    hideAllStates_AMCmpLoadingAd();
    $("#AMCmpLoadingAd_agrega_5").show();
  });

  $("#btn_AMCmpLoadingAd_agrega_5_6_y_7").click(function() {
    hideAllStates_AMCmpLoadingAd();
    $("#AMCmpLoadingAd_agrega_5_6_y_7").show();
  });

  $("#btn_AMCmpLoadingAd_remueve_input_1").click(function() {
    hideAllStates_AMCmpLoadingAd();
    $("#AMCmpLoadingAd_remueve_input_1").show();
  });

  $("#btn_AMCmpLoadingAd_remueve_2_y_4").click(function() {
    hideAllStates_AMCmpLoadingAd();
    $("#AMCmpLoadingAd_remueve_2_y_4").show();
  });
});

function hideAllStates_AMCmpLoadingAd() {
  $("#AMCmpLoadingAd_baseState").hide();
  $("#AMCmpLoadingAd_agrega_5").hide();
  $("#AMCmpLoadingAd_agrega_5_6_y_7").hide();
  $("#AMCmpLoadingAd_remueve_input_1").hide();
  $("#AMCmpLoadingAd_remueve_2_y_4").hide();
}
