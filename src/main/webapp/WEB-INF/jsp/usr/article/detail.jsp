<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세내용" />
<%@ include file="../common/head.jspf" %>

<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__viewDone';
		
		if ( localStorage.getItem(localStorageKey) ) {
			return;
		}
		
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode: 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
	$(function() {
		// 실전코드
		// ArticleDetail__increaseHitCount();
		
		// 임시코드
		setTimeout(ArticleDetail__increaseHitCount, 500);
	})
</script>
   <section>
      <div class="container mx-auto px-3 mt-5">
        <div class="table-box-type-1">
          <table border="1">
            <colgroup>
              <col width="200">
             </colgroup>
            <tbody>
                <tr>
                  <th>번호</th>
                  <td>
                  <div class="badge badge-md">${article.id}</div>
                  </td>
                  <tr></tr>

                  <th>작성날짜</th>
                  <td>${article.forPrintType2RegDate}</td>
                  <tr></tr>

                  <th>수정날짜</th>
                  <td>${article.forPrintType2UpdateDate}</td>
                  <tr></tr>

                  <th>작성자</th>
                  <td>${article.extra__writerName}</td>
                  <tr></tr>

                  <th>조회수</th>
                  <td>
                    <span class="badge article-detail__hit-count">
                      ${article.hitCount}
                    </span>
                  </td>
                  <tr></tr>

                  <th>추천</th>
                  <td>
                    <span class="badge article-detail__hit-count">
                      ${article.goodReactionPoint}
                    </span>
                    
                    <c:if test="${actorCanMakeReaction}">
                  <a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" class="btn btn-xs btn-primary btn-outline">
                    좋아요
                    👍
                  </a>
                  <span>&nbsp;</span>
                  <a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" class="btn btn-xs btn-secondary btn-outline">
                    싫어요
                    👎
                  </a>
                </c:if>
                
                <c:if test="${actorCanCancelGoodReaction}">
                  <a href="/usr/reactionPoint/doCancelGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" class="btn btn-xs btn-primary">
                    좋아요 👍
                  </a>
                  <span>&nbsp;</span>
                  <a onclick="alert(this.title); return false;" title="먼저 좋아요를 취소해주세요." href="#" class="btn btn-xs btn-secondary btn-outline">
                    싫어요 👎
                  </a>
                </c:if>
                
                <c:if test="${actorCanCancelBadReaction}">
                  <a onclick="alert(this.title); return false;" title="먼저 싫어요를 취소해주세요." href="#" class="btn btn-xs btn-primary btn-outline">
                    좋아요 👍
                  </a>
                  <span>&nbsp;</span>
                  <a href="/usr/reactionPoint/doCancelBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" class="btn btn-xs btn-secondary">
                    싫어요 👎
                  </a>
                </c:if>
                    
                  </td>
                  <tr></tr>
                  
                  <th>제목</th>
                  <td>
                    ${article.title}
                  </td>
                  <tr></tr>
                  <th>내용</th>
                  <td>
                    ${article.body}
                  </td>
                </tr>
            </tbody>
          </table>
        </div>
        <div class="btns">
          <button class="btn btn-link" type="button" onclick="history.back();">뒤로가기</button>
          <c:if test="${article.extra__actorCanModify}">
          <a class="btn btn-link" href="../article/modify?id=${article.id}">게시물 수정</a>
          </c:if>
          <c:if test="${article.extra__actorCanDelete}">
          <a class="btn btn-link" onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;" href="../article/doDelete?id=${article.id}">게시물 삭제</a>
          </c:if>
        </div>
    </div>
  </section>
  <section class="mt-5">
    <div class="container mx-auto px-3">
      <h1>댓글 작성</h1>
      <c:if test="${rq.logined}">
      <form class="table-box-type-1" method="POST" action="../reply/doWrite">
        <input type="hidden" name="relTypeCode" value="article">
        <input type="hidden" name="relId" value="${article.id}">
        <table>
          <colgroup>
            <col width="200" />
          </colgroup>
          <tbody>
            <tr>
              <th>작성자</th>
              <td>
                <div class="badge">${rq.loginedMember.nickname }</div>
              </td>
            </tr>
            <tr>
              <th>내용</th>
              <td>
                <textarea required="required" class="w-full textarea textarea-bordered " name="body" rows="5" placeholder="내용을 입력해주세요."></textarea>
              </td>
            </tr>
            <tr>
              <th>댓글작성</th>
              <td>
                <button type="submit" class="btn btn-outline btn-primary">댓글작성</button> 
              </td>
            </tr>
          </tbody>
        </table>
      </form>
      </c:if>
      <c:if test="${rq.notLogined}">
        <a href="/usr/member/login" class="link link-primary">로그인</a> 후 이용해주세요.
      </c:if>
    </div>
  </section>
  <%@ include file="../common/foot.jspf" %>
