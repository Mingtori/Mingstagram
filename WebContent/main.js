function SaveWrite_reg() {
	if ($("#id").val() == "") {
		alert("아이디를 입력해주세요.");
		$("#id").focus();
		return false;
	}
	if ($("#name").val() == "") {
		alert("이름을 입력해주세요.");
		$("#name").focus();
		return false;
	}
	if ($("#email").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#email").focus();
		return false;
	}
	if ($("#password").val() == "") {
		alert("비밀번호를 입력해주세요.");
		$("#password").focus();
		return false;
	}
}
function SaveWrite_log() {
	if ($("#login_id").val() == "") {
		alert("아이디 입력해주세요.");
		$("#login_id").focus();
		return false;
	}
	if ($("#login_password").val() == "") {
		alert("비밀번호 입력해주세요.");
		$("#login_password").focus();
		return false;
	}
}
$(function() {
	$("#login").click(function() {
		$("#login_f").toggle();
	});
});