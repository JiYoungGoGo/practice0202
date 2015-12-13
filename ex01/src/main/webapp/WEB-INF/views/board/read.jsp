<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>

<!------------------------------ Main content -------------------------------->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">

			<!-- general from elements -->
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">조회페이지!</h3>

					<form role="form" method="post">
					
						<input type="hidden" name="bno" value="${VO.bno}">
					
					</form>



					<div class="box-body">

						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name="title" class="form-control" readonly="readonly" value="${VO.title }">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="text" rows="3"
								readonly="readonly" > ${VO.text} </textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${VO.writer}" readonly="readonly">
						</div>

					</div>
					<!-- /box-body -->

					<div class="box-footer">
						<button type="submit" class="btn btn-warnion"> 수정</button>
						<button type="submit" class="btn btn-danger"> 삭제</button>
						<button type="submit" class="btn btn-primary"> 목록</button>
						
					</div>





				</div>

			</div>

		</div>
		<!-- /.col(left) -->

	</div>
	<!-- /.row -->

</section>
<!-- /.content -->

<%@include file="../include/footer.jsp"%>
<script>
	
	
	
	
	$(document).ready(function(){
		var formObj = $("form[role='form']");
		
		console.log("FORMOBJ: "+formObj);
		
		$(".btn-warnion").on("click",function(){
			formObj.attr("action", "/board/modify");
			formObj.attr("method","get");
			formObj.submit();
		
		});
		
		$(".btn-danger").on("click",function(){
			formObj.attr("action", "/board/remove");
			formObj.submit();
		
		});
		
		$(".btn-primary").on("click",function(){
			self.location = "/board/list";
		
		});
		
	});
	
	
	
	
</script>
</body>
</html>