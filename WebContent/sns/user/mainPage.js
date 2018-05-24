//덧글 수정확인
function reb_ok(_rno, _bno) {
	$.ajax({
		url : "../reboard/reboardUpdate.jsp",
		data : ({
			rno : _rno,
			contents : $("#reb_upcon" + _rno).val()
		}),
		success : function(data) {
			$.ajax({
				url : "../reboard/reboardView.jsp",
				dataType : "html",
				data : ({
					bno : _bno
				}),
				success : function(data) {
					$("#tb" + _bno).html(data);
				}
			})
		}
	})
}
// 덧글수정
function reb_upd(rno) {
	$("#reb_con" + rno).hide();
	$("#reb_up_btn" + rno).hide();
	$("#reb_del_btn" + rno).hide();
	$("#reb_ok_btn" + rno).show();
	$("#reb_upcon" + rno).show();
}
// 덧글삭제
function reb_del(_rno, _bno) {
	$.ajax({
		url : "../reboard/reboardDelete.jsp",
		data : ({
			rno : _rno
		}),
		success : function(data) {
			$.ajax({
				url : "../reboard/reboardView.jsp",
				dataType : "html",
				data : ({
					bno : _bno
				}),
				success : function(data) {
					$("#tb" + _bno).html(data);
				}
			})
		}
	})
}
// 덧글쓰기
function reb_btn(_bno) {
	$.ajax({
		url : "../reboard/reboardWrite.jsp",
		dataType : "html",
		data : ({
			bno : _bno,
			contents : $("#reboard_con" + _bno).val()
		}),
		success : function(data) {
			$.ajax({
				url : "../reboard/reboardView.jsp",
				dataType : "html",
				data : ({
					bno : _bno,
				}),
				success : function(data) {
					$("#tb" + _bno).html(data);
					$("#reboard_con" + _bno).val("");
				}
			})
		}
	})
}
// 게시글 수정
function modal_view(bno, bimage, contents) {
	/*
	 * REPLACE를 REPLACEALL 처럼 사용하기 - g : 발생할 모든 pattern에 대한 전역 검색 - i : 대/소문자 구분
	 * 안함 - m: 여러 줄 검색 (참고)
	 */
	str = contents.replace(/<br>/gi, "\r\n");
	$("#bno").val(bno);
	$("#contents").val(str);
	$("#old_bimage").val(bimage);
}

// 이미지 삭제
function image_del() {
	location.href = "../board/updateBoard.jsp?flag=1&bno=" + $("#bno").val()
			+ "&old_bimage=" + $("#old_bimage").val();
}

// 유효성검사
function SaveWrite() {
	if ($("textarea[name='contents']").val() == "") {
		alert("내용을 입력해주세요");
		$("textarea[name='contents']").focus();
		return false;
	}
}

// 덧글쓰기 버튼 누르면 덧글리스트 불러움
function comentToggle(_bno) {
	$("#coment" + _bno).toggle();
	$.ajax({
		url : "../reboard/reboardView.jsp",
		dataType : "html",
		data : ({
			bno : _bno,
			contents : $("#reboard_con" + _bno).val()
		}),
		success : function(data) {
			$("#tb" + _bno).html(data);
		}
	})
}