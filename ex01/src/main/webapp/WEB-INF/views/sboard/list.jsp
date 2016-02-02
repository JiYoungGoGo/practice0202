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
					<h3 class="box-title">목록페이지</h3>


					<!-- 검색할거다 -->
					<div class="box-body">


					<select name="searchType">
				  	<option value="n" <c:out value="${cri.searchType == null?'selected':' ' }" />>---</option>
				  	<option value="t" <c:out value="${cri.searchType eq 't' ?'selected':' ' }" />>제목</option>
				  	<option value="c" <c:out value="${cri.searchType eq 'c'?'selected':' ' }" />>내용</option>
				  	<option value="w" <c:out value="${cri.searchType eq 'w'?'selected':' ' }" />>작성자</option>
				  	<option value="tc" <c:out value="${cri.searchType eq 'tc'?'selected':' ' }" />>제목+내용</option>
				  	<option value="cw" <c:out value="${cri.searchType eq 'cw'?'selected':' ' }" />>내용+작성자</option>
				  	<option value="tw" <c:out value="${cri.searchType eq 'tw'?'selected':' ' }" />>제목+작성자</option>
				  	<option value="tcw" <c:out value="${cri.searchType eq 'tcw'?'selected':' ' }" />>제목+내용+작성자</option>
				  </select> 
						<input type="text" name="keyword" id="keywordInput"
							value="${cri.keyword }">
						<button id="searchBtn">Search</button>
						<button type="submit" id="newBtn">글쓰기</button>
					</div>


					<input type="hidden" id="page" value="${cri.page}">

					<table class="table table-bordered">
						<tr>
							<th style="width: 10px">BNO</th>
							<th>TITLE</th>
							<th>WRITER</th>
							<th>REGDATE</th>
							<th style="width: 40px">VIEWCOUNT</th>
						</tr>

						<c:forEach items="${list}" var="list">
							<tr>
								<td>${list.bno }</td>
								<td><a
									href="/sboard/read${pageMaker.makeSearch(cri.page)}&bno=${list.bno}">${list.title }</a></td>
								<td>${list.writer }</td>
								<!-- 날짜 들어가야 되는 자리 -->
								<td>등록날짜</td>
								<td><span class="badge bg-red"> ${list.viewCount } </span>
								</td>
							</tr>
						</c:forEach>
					</table>

					<!-- <div class="box-footer">
						<button type="submit" class="btn btn-primary"> 글쓰기 </button>
					</div> -->

					<!-- 여기는 페이징 처리 하는 곳 -->
					<div class="text-center">
						<div class="pagination">

							<c:if test="${pageMaker.prev }">
								<li>
								
								<a
									href="list${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="paging">
								<li
									<c:out value="${cri.page==paging?'class=active':'' }"/>>
									<a href="list${pageMaker.makeSearch(paging)}">${paging }</a>
								</li>

							</c:forEach>


							<c:if test="${pageMaker.next }">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.endPage+1) }">&raquo;</a></li>
							</c:if>


						</div>

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
	$(document).ready(function() {

		var num = $('#page').val;
		
		console.log("num: "+num);
		
		$('#searchBtn').on("click", function(event){
			//self.location="list"+"${pageMaker.makeQuery(num)}";
			event.preventDefault();
			self.location="list" 
			+'${pageMaker.makeQuery(1)}'
			+"&searchType="
			+$("select option:selected").val()
			+"&keyword="+$('#keywordInput').val();
			
		});
		
		$('#newBtn').on("click",function(event){
			
			self.location="register";
			
		});
		
		
		var str = '${msg}';
		console.log(str);

		if (str == 'SUCCESS') {
			alert("등록되었습니다.");
			
			
		} else if (str == "MODIFY") {
			alert("수정되었습니다. ");
		} else if (str == 'DELETE') {
			alert("삭제되었습니다. ");

		}

		
	});


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