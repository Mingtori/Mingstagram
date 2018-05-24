<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">글 수정</h4>
				</div>
			<form action="<%=request.getContextPath() %>/sns/board/updateBoard.jsp" method="post" enctype="multipart/form-data" name="f">
				<div class="modal-body">
					<input type="hidden" name="bno" id="bno">
					<input type="hidden" name="old_bimage" id="old_bimage">
					<textarea class="form-control" name="contents" id="contents" rows="4" style="resize:none; margin-bottom:10px"></textarea>
				</div>
				<div class="modal-footer">
					<div class="btn-group">
						<label class="btn btn-default btn-file">
							이미지선택 <input type="file" name="bimage" style="display: none;">
						</label>
						<input type="button" class="btn btn-default" value="삭제" onClick="image_del();">
					</div>
					<input type="submit" class="btn btn-primary" value="확인">
				</div>
			</form>
		</div>
	</div>
</div>