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
					<h3 class="box-title">수정 페이지</h3>

					<form role="form" method="post">

					  <input type="hidden" name="page" value="${cri.page}">
					  <input type="hidden" name="perPageNum" value="${cri.perPageNum }">
					  
						<div class="box-body">
							
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> 
								<input type="text" name="bno" class="form-control" value="${VO.bno }" readonly="readonly">
							</div>
							
							
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> 
								<input type="text"
									name="title" class="form-control" value="${VO.title }">
							</div>
							
							
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="text" rows="3"> ${VO.text}</textarea>
							</div>
							
							
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label> <input type="text"
									name="writer" class="form-control" value="${VO.writer}">
							</div>

						</div>
						
						<div class="box-footer">
						<button type="submit" class="btn btn-primary"> 저장 </button>
						<button type="submit" class="btn btn-warning"> 취소 </button>
						
						</div>


					</form>




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
		
		console.log(formObj);
		
		$(".btn-warning").on("click",function(){
			formObj.attr("method","get");
			formObj.attr("action", "/board/readPage?bno='${VO.bno}'"); 
			//self.location= "/board/readPage?bno=${VO.bno}&page=${cri.page}&perPageNum=${cri.perPageNum}";
			
		});
		
		
		$(".btn-primary").on("click",function(){
			
			formObj.submit();
			
		});
		
	});
	
	
</script>
</body>
</html>