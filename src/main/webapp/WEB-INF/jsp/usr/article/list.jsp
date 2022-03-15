<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../common/head.jspf" %>
   <section>
      <div class="container mx-auto px-3 mt-5">
      <div class="flex">
        <div>
          게시물 개수 : <div class="badge">${articlesCount}</div> 개
        </div>
        <div class="flex-grow"></div>
        <form class="flex">
          <input type="hidden" name="boardId" value="${param.boardId}">
          <select data-value="${param.searchKeywordTypeCode}" name="searchKeywordTypeCode" class="select select-bordered">
            <option disabled="disabled">검색타입</option>
            <option value="title">제목</option>
            <option value="body">내용</option>
            <option value="title,body">제목+내용</option>
          </select>
          <input type="text" name="searchKeyword" class="input input-bordered ml-2 w-64" placeholder="검색어를 입력해주세요." maxlength="20" value="${param.searchKeyword}">
          <button class="submit btn btn-accent ml-2">검색</button>
        </form>
      </div>
        <div class="overflow-x-auto mt-5">
          <table class="table table-zebra w-full block truncate" >
            <colgroup>
              <col width="50">
              <col width="100">
              <col width="100">
              <col width="50">
              <col width="50">
              <col width="150">
              <col>
              <col>
            </colgroup>
            <thead>
              <tr>
                <th>번호</th>
                <th>작성날짜</th>
                <th>수정날짜</th>
                <th>조회수</th>
                <th>추천수</th>
                <th>작성자</th>
                <th>제목</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="article" items="${articles}">
                <tr>
                  <th>${article.id}</th>
                  <td>${article.forPrintType1RegDate}</td>
                  <td>${article.forPrintType1UpdateDate}</td>
                  <td>${article.hitCount}</td>
                  <td>${article.goodReactionPoint}</td>
                  <td>${article.extra__writerName}</td>
                  <td>
                    <a class="btn-text-link w-full block truncate" href="../article/detail?id=${article.id}">
                      ${article.title}
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <div class="page-menu mt-5">
          <div class="btn-group justify-center">
            <c:set var="pageMenuArmLen" value="6" />
            <c:set var="startPage" value="${page - pageMenuArmLen >= 1 ? page - pageMenuArmLen : 1}" />
            <c:set var="endPage" value="${page + pageMenuArmLen <= pagesCount ? page + pageMenuArmLen : pagesCount}" />


            <c:set var="pageBaseUri" value="?boardId=${boardId}" />
            <c:set var="pageBaseUri" value="${pageBaseUri}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
            <c:set var="pageBaseUri" value="${pageBaseUri}&searchKeyword=${param.searchKeyword}" />
            
            <c:if test="${startPage > 1}">
            <a class="btn" href="${pageBaseUri}&page=1">1</a>
            <c:if test="${startPage > 2}">
            <a class="btn btn btn-disabled">...</a>
            </c:if>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
              <a class="btn ${page == i ? 'btn-active' : ''}" href="${pageBaseUri}&page=${i}">${i}</a>
            </c:forEach>
            <c:if test="${endPage < pagesCount}">
              <c:if test="${endPage < pagesCount - 1}">
                <a class="btn btn btn-disabled">...</a>
              </c:if>
            <a class="btn" href="${pageBaseUri}&page=${pagesCount}">${pagesCount}</a>
            </c:if>
          </div>
        </div>
    </div>
  </section>
  <%@ include file="../common/foot.jspf" %>
