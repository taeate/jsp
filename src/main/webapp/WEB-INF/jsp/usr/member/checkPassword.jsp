<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="비밀번호 확인" />
<%@ include file="../common/head.jspf" %>
   <section>
      <div class="container mx-auto px-3 mt-5">
        <form class="table-box-type-1" method="post" action="../member/doCheckPassword">
        <input type="hidden" name="replaceUri" value="${param.replaceUri}">
          <table border="1">
            <colgroup>
              <col width="200">
             </colgroup>
            <tbody>
                <tr>
                  <th>로그인아이디</th>
                  <td>
                    ${rq.loginedMember.loginId}
                  </td>
                  <tr></tr>

                  <th>로그인비밀번호</th>
                  <td>
                    <input name="loginPw" type="password" placeholder="로그인비밀번호" class="input input-bordered input-primary w-full max-w-xs" required="required">
                  </td>
                  <tr></tr>

                  <th>로그인</th>
                  <td>
                 
                    <button type="submit"  class="btn btn-outline btn-primary bg-blue-500">비밀번호확인</button>
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
