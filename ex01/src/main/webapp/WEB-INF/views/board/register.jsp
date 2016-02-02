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
					<h3 class="box-title">등록 페이지</h3>

					<form role="form" method="post">

						<div class="box-body">
							
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> 
								<input type="text"
									name="title" class="form-control" placeholder="Enter Title..">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="text" rows="3" placeholder="text.."></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">writer</label> <input type="text"
									name="writer" class="form-control" placeholder="Enter Writer..">
							</div>

						</div>
						
						<div class="box-footer">
						<button type="submit" class="btn btn-primary"> Submit </button>
						
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
	
</script>
</body>
</html>