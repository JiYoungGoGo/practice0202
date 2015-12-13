<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../include/header.jsp" %>

     <!------------------------------ Main content -------------------------------->
	<section class="content">
		<div class="row">
		<!-- left column -->
		<div class="col-md-12">
		
		<!-- general from elements -->
			<div class="box">
				<div class="box-header with-border">
				 <h3 class="box-title">목록페이지</h3>
				
				<table class="table table-bordered">
				<tr>
					<th style="width: 10px">BNO </th>
					<th>TITLE</th>
					<th>WRITER</th>
					<th>REGDATE</th>
					<th style="width: 40px"> VIEWCOUNT</th>
				</tr>
				
				<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.bno }</td>
					<td><a href="/board/read?bno=${list.bno }">${list.title }</a></td>
					<td>${list.writer }</td>
					<!-- 날짜 들어가야 되는 자리 -->
					<td> 등록날짜</td>
					<td><span class="badge bg-red"> ${list.viewCount } </span> </td>
				</tr>
				</c:forEach>
				</table>
					
					 <div class="box-footer">
						<button type="submit" class="btn btn-primary"> 글쓰기 </button>
					</div> 
				
				
				</div>
			
			</div>
		
		</div><!-- /.col(left) -->
		
		</div><!-- /.row -->
	
	</section><!-- /.content -->
   
<%@include file="../include/footer.jsp" %>
<script>

	$(document).ready(function(){
		$(".btn-primary").on("click",function(){
	
			self.location="/board/register";
			
		});
	});

	var str = '${msg}';
	console.log(str);
	
	if(str == 'SUCCESS'){
		alert("등록되었습니다.");
	}
	else if(str == "MODIFY"){
		alert("수정되었습니다. ");
	}
	else if(str == 'DELETE'){
		alert("삭제되었습니다. ");
		
	}

	/* $(document).ready(function(){
		
	
		$(".btn-primary").on("click",function(){
			
			var frame = window.frameElement;
		    
		    if (frame) { 
		        frame.src = "http://localhost/board/regist";
		    }
			
		}); */
		
	// });

</script>
  </body>
</html>