<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/template/isMember.jsp" %>
	
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<!-- 데이트 피커 -->
	<link rel="stylesheet" href="/baby/resources/css/jquery.simple-dtpicker.css"/>
	<script type="text/javascript" src="/baby/resources/js/jquery.simple-dtpicker.js"></script>
	<!-- 카풀map시작-->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1fc37be4712f8b89b167cddbc490382f"></script>
	<!-- 주소검색 자동완성 api -->
	<link rel="stylesheet" href="/baby/resources/css/s9jss_single.css"> 
	<script type="text/javascript" src="/baby/resources/js/s9soft.js"></script>
	
	<!-- 섬머노트 css/js -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.js"></script>
	<!-- 섬머노트 한국어 설정 -->
	<script src="/baby/resources/summernote/summernote-ko-KR.js"></script>
 	<!-- 시큐리티 -->

<style>
.carinput_head {
  margin-bottom: 10px;
}
.carinput_icon {
  color: #f68181;
  width: 50px;
}
.carinput_title {
  display: inline-block;
  margin-bottom: 0;
  vertical-align: middle;
}
.carinput_body {
  margin: 0;
}
.custom_Button {
  width: 140px;
  background-color: #f68181;
  color: white;
  border: none;
  border-radius: 5px;
}
.box_map {
 
  height: 300px;
}
#sun {
  border-bottom: 5px solid #f68181;
  margin-top: 0;
}

.carinput_form .col-form-label {
  padding-left: 16px;
}
.btngroup {
  margin-top: 30px;
}
.datepicker_table {
  width: 197px;
}
g {
display: none;
}
.datepicker_timelist {
  height: 128px;
}
</style>
<div class="site-section" style="padding: 2em;">
	<div class="container">	
		<div class="carinput_head">
			<img class="carinput_icon" alt="아이콘" src="/baby/resources/images/car_icon2.png">
			<h2 class="carinput_title">카풀 등록하기</h2>
		</div>
		<hr id="sun"/>
		<div class="carinput_body">
			<form class="carinput_form" action="Carinsert.kosmo" method="post">
				<div class="row no-gutter">
					<div class="col-md-8 col-lg-6">
						<div class="form-group">
							<label for="purpose" class="col-form-label purpose">유형: </label> 
							<div class="col">					
								<select	class="form-control" id="type" name="type">
									<option>타세요</option>
									<option>태워주세요</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="start" class="col-form-label">출발지: </label>
							<div class="col">
								<input type="text" id="start" name="startpoint" value="${list.startpoint }" class="form-control search_point" placeholder="출발위치" />
							</div>
						</div>
						<div class="form-group">
							<label for="end" class="col-form-label">도착지: </label>
							<div class="col">
								<input type="text" id="end" name="endpoint" value="${list.endpoint }" class="form-control search_point" placeholder="도착위치" />
							</div>
						</div>
						<!-- 출발 도착 위치 위도, 경도 저장용 -->
						<input class="form-control" type="hidden" id="start_xpos" name="start_xpos" value="${list.s_xpos }"/>
						<input class="form-control" type="hidden" id="start_ypos" name="start_ypos" value="${list.s_ypos }"/>
						<input class="form-control" type="hidden" id="end_xpos" name="end_xpos" value="${list.e_xpos }"/>
						<input class="form-control" type="hidden" id="end_ypos" name="end_ypos" value="${list.e_ypos }"/>
						<input class="form-control" type="hidden" id="cp_no" name="cp_no" value="${list.cp_no }"/>
						 <input class="form-control" type="hidden" id="id" name="id" value="${id }"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<div class="form-group">
							<label for="point" class="col-form-label pay">금액: </label>
							<div class="col">
								<input type="text" id="price" name="price" class="form-control" placeholder="금액 입력해주세요" value="${list.price }"/>
							</div>
						</div>
						<div class="form-group">
							<label for="datepicker1" class="col-form-label pay">날짜: </label>
							<div class="col">
								<input type="text" id="time" name="time" class="form-control" placeholder="날짜 입력해주세요" value="${list.time }"/>
							</div>
						</div>
					</div>
					<!-- 추가내용 -->
					<div class="col-md-8 col-lg-6">
						<div class="form-group">
							<label for="summernote" class="col-form-label">추가내용: </label>
							<textarea id="content" class="form-control" name="content">${list.content }</textarea>
						</div>
					</div>
				</div>
			</form>
			
		</div>
		<div class="col">
			<div id="map" class="box_map"></div>
		</div>
		<div class="btngroup text-center">
			<button type="button" class="btn btn-primary custom_Button submit">확인</button>
			<button type="button" id="edit" class="btn btn-primary custom_Button">수정</button>
			<button type="button" class="btn btn-primary custom_Button">취소</button>
		</div>
	</div>
</div>
<script src="/baby/resources/js/carinput_Map.js"></script>


<script>
$(function(){
	$('.submit').click(function(){		
		$('.carinput_form').submit();
		
	});
	$('#edit').click(function(){
		$('.carinput_form').prop('action','Carupdate.kosmo')
		$('.carinput_form').submit();
		
	});
	
	
	$('*[name=time]').appendDtpicker({
		"locale": "ko"
	});
	
	$('#content').summernote({
		placeholder: 'Hello bootstrap 4',
		height: 400,
		lang: 'ko-KR',
		minHeight: null,
		maxHeight: null,
		tabsize: 2
	});
	//$("#affected").zInput();
});
</script>
	  