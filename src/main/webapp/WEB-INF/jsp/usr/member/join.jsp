<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../common/head.jspf" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
   <section>
      <div class="container mx-auto px-3 mt-5">

        <script type="text/javascript">
          let submitJoinFormDone = false;
          let validLoginId = "";
          function submitJoinForm(form) {
            if (submitJoinFormDone) {
              alert('처리중입니다.');
              return;
            }
            form.loginId.value = form.loginId.value.trim();
            if (form.loginId.value.length == 0) {
              alert('로그인아이디를 입력해주세요.');
              form.loginId.focus();
              return;
            }

            if (form.loginId.value != validLoginId ) {
              alert('해당 로그인아이디는 올바르지 않습니다. 다른 로그인아이디를 입력해주세요.');
              form.loginId.focus();

              return;
            }

            form.loginPw.value = form.loginPw.value.trim();
            if (form.loginPw.value.length == 0) {
              alert('로그인비밀번호를 입력해주세요.');
              form.loginPw.focus();
              return;
            }
            form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
            if (form.loginPwConfirm.value.length == 0) {
              alert('로그인비밀번호 확인을 입력해주세요.');
              form.loginPwConfirm.focus();
              return;
            }
            if (form.loginPw.value != form.loginPwConfirm.value) {
              alert('로그인비밀번호 확인이 일치하지 않습니다.');
              form.loginPwConfirm.focus();
              return;
            }
            form.name.value = form.name.value.trim();
            if (form.name.value.length == 0) {
              alert('이름을 입력해주세요.');
              form.name.focus();
              return;
            }
            form.nickname.value = form.nickname.value.trim();
            if (form.nickname.value.length == 0) {
              alert('닉네임을 입력해주세요.');
              form.nickname.focus();
              return;
            }
            form.email.value = form.email.value.trim();
            if (form.email.value.length == 0) {
              alert('이메일을 입력해주세요.');
              form.email.focus();
              return;
            }
            form.cellphoneNo.value = form.cellphoneNo.value.trim();
            if (form.cellphoneNo.value.length == 0) {
              alert('휴대전화번호를 입력해주세요.');
              form.cellphoneNo.focus();
              return;
            }
            submitJoinFormDone = true;
            form.submit();
          }

          function checkLoginIdDup(el) {
            $('.loginId-message').html('<div class="mt-2">체크중..</div>');
            const form = $(el).closest('form').get(0);

            if ( form.loginId.value.length == 0 ) {
              validLoginId = "";
              return;
            }

            $.get(
              '../member/getLoginIdDup',
              {
                isAjax : 'Y',
                loginId: form.loginId.value
              }, function(data) {
                $('.loginId-message').html('<div class="mt-2">' + data.msg + '</div>');
                if ( data.success) {
                  validLoginId = data.data1;
                }
                else {
                  validLoginId = '';
                }
              }, 'json');
          }

          const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 300);
        </script>
        

        <form class="table-box-type-1" method="post" action="../member/doJoin" onsubmit="submitJoinForm(this); return false;">
          <input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" >
          <table border="1">
            <colgroup>
              <col width="200">
             </colgroup>
            <tbody>
                <tr>
                  <th>로그인아이디</th>
                  <td>
                   <input onkeyup="checkLoginIdDupDebounced(this);" name="loginId" type="text" placeholder="로그인아이디" class="input input-bordered input-primary w-full max-w-xs">
                   <div class="loginId-message"></div>
                  </td>
                  <tr></tr>

                  <th>로그인비밀번호</th>
                  <td>
                    <input name="loginPw" type="password" placeholder="로그인비밀번호" class="input input-bordered input-primary w-full max-w-xs">
                  </td>
                  <tr></tr>

                  <th>로그인비밀번호 확인</th>
                  <td>
                    <input name="loginPwConfirm" type="password" placeholder="로그인비밀번호" class="input input-bordered input-primary w-full max-w-xs">
                  </td>
                  <tr></tr>

                  <th>이름</th>
                  <td>
                    <input name="name" type="text" placeholder="이름" class="input input-bordered input-primary w-full max-w-xs">
                  </td>
                  <tr></tr>

                  <th>닉네임</th>
                  <td>
                    <input name="nickname" type="text" placeholder="닉네임" class="input input-bordered input-primary w-full max-w-xs">
                  </td>
                  <tr></tr>

                  <th>이메일</th>
                  <td>
                    <input name="email" type="email" placeholder="이메일" class="input input-bordered input-primary w-full max-w-xs">
                  </td>
                  <tr></tr>

                  <th>전화번호</th>
                  <td>
                    <input name="cellphoneNo" type="text" placeholder="전화번호" class="input input-bordered input-primary w-full max-w-xs">
                  </td>
                  <tr></tr>

                  <th>회원가입</th>
                  <td>
                 
                    <button type="submit"  class="btn btn-outline btn-primary">회원가입</button>
                    <button class="btn btn-outline btn-secondary" type="button" onclick="history.back();">뒤로가기</button>
                  </td>
                  <tr></tr>
                </tr>
            </tbody>
          </table>
        </form>
    </div>
  </section>
  <%@ include file="../common/foot.jspf" %>
