<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <c:set var="pageTitle" value="게시물 내용" />
    <%@ include file="../common/head.jspf" %>
      <%@ include file="../../common/toastUiEditorLib.jspf" %>
        <script>
          const params = {};
          params.id = parseInt('${param.id}');
        </script>

        <script>
          function ArticleDetail__increaseHitCount() {
            const localStorageKey = 'article__' + params.id + '__viewDone';
            if (localStorage.getItem(localStorageKey)) {
              return;
            }
            localStorage.setItem(localStorageKey, true);
            $.get('../article/doIncreaseHitCountRd', {
              id: params.id,
              ajaxMode: 'Y'
            }, function (data) {
              $('.article-detail__hit-count').empty().html(data.data1);
            }, 'json');
          }
          $(function () {
            // 실전코드
            // ArticleDetail__increaseHitCount();
            // 임시코드
            setTimeout(ArticleDetail__increaseHitCount, 500);
          })
        </script>
        <section class="mt-5 mx-auto">
          <div class="container mx-auto px-3">
            <table>
              <colgroup>
                <col width="200" />
              </colgroup>
              <tbody>
                <tr>
                  <th>번호</th>
                  <td>
                    <div class="badge badge-primary">${article.id}</div>
                  </td>
                </tr>
                <tr>
                  <th>작성날짜</th>
                  <td>${article.forPrintType2RegDate}</td>
                </tr>
                <tr>
                  <th>수정날짜</th>
                  <td>${article.forPrintType2UpdateDate}</td>
                </tr>
                <tr>
                  <th>작성자</th>
                  <td>${article.extra__writerName}</td>
                </tr>
                <tr>
                  <th>조회</th>
                  <td>
                    <span class="badge badge-primary article-detail__hit-count">${article.hitCount}</span>
                  </td>
                </tr>
                <tr>
                  <th>추천</th>
                  <td>
                    <div class="flex items-center">
                      <span class="badge badge-primary">${article.goodReactionPoint}</span>
                      <span>&nbsp;</span>

                      <c:if test="${actorCanMakeReaction}">
                        <a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                          class="btn btn-xs btn-primary btn-outline"> 좋아요
                          👍 </a>
                        <span>&nbsp;</span>
                        <a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                          class="btn btn-xs btn-secondary btn-outline">
                          싫어요 👎 </a>
                      </c:if>

                      <c:if test="${actorCanCancelGoodReaction}">
                        <a href="/usr/reactionPoint/doCancelGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                          class="btn btn-xs btn-primary"> 좋아요 👍 </a>
                        <span>&nbsp;</span>
                        <a onclick="alert(this.title); return false;" title="먼저 좋아요를 취소해주세요." href="#"
                          class="btn btn-xs btn-secondary btn-outline">
                          싫어요 👎 </a>
                      </c:if>

                      <c:if test="${actorCanCancelBadReaction}">
                        <a onclick="alert(this.title); return false;" title="먼저 싫어요를 취소해주세요." href="#"
                          class="btn btn-xs btn-primary btn-outline"> 좋아요
                          👍 </a>
                        <span>&nbsp;</span>
                        <a href="/usr/reactionPoint/doCancelBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                          class="btn btn-xs btn-secondary"> 싫어요 👎 </a>
                      </c:if>

                    </div>
                  </td>
                </tr>
                <tr>
                  <th>제목</th>
                  <td>${article.title}</td>
                </tr>
                <tr>
                  <th>내용</th>
                  <td>
                    <div class="toast-ui-viewer">
                      <script type="text/x-template">
              ${article.body}
              </script>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>

            <div class="btns">
              <c:if test="${empty param.listUri}">
                <button class="btn btn-link" type="button" onclick="history.back();">뒤로가기</button>
              </c:if>
              <c:if test="${not empty param.listUri}">
                <a class="btn btn-link" href="${param.listUri}">뒤로가기</a>
              </c:if>

              <c:if test="${article.extra__actorCanModify}">
                <a class="btn btn-link" href="../article/modify?id=${article.id}">게시물 수정</a>
              </c:if>
              <c:if test="${article.extra__actorCanDelete}">
                <a class="btn btn-link" onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;"
                  href="../article/doDelete?id=${article.id}">게시물 삭제</a>
              </c:if>
            </div>
          </div>
        </section>

        <script>
          // 댓글작성 관련
          let ReplyWrite__submitFormDone = false;
          function ReplyWrite__submitForm(form) {
            if (ReplyWrite__submitFormDone) {
              return;
            }
            // 좌우공백 제거
            form.body.value = form.body.value.trim();
            if (form.body.value.length == 0) {
              alert('댓글을 입력해주세요.');
              form.body.focus();
              return;
            }
            if (form.body.value.length < 2) {
              alert('댓글내용을 2자이상 입력해주세요.');
              form.body.focus();
              return;
            }
            ReplyWrite__submitFormDone = true;
            form.submit();
          }
        </script>

        <section class="mt-5">
          <div class="container mx-auto px-3">

            <c:if test="${rq.logined}">
              <form class="table-box-type-1" method="POST" action="../reply/doWrite"
                onsubmit="ReplyWrite__submitForm(this); return false;">
                <input type="hidden" name="replaceUri" value="${rq.currentUri}" />
                <input type="hidden" name="relTypeCode" value="article" />
                <input type="hidden" name="relId" value="${article.id}" />
                <table>
                  <colgroup>
                    <col width="200" />
                  </colgroup>


                  <label for="message"
                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400">${rq.loginedMember.nickname}</label>
                  <textarea id="message" rows="4" name="body"
                    class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    placeholder="댓글을 작성해주세요."></textarea>
                  <button type="submit" class="btn btn-primary bg-blue-500 mt-2">댓글작성</button>

                </table>
              </form>
            </c:if>
            <c:if test="${rq.notLogined}">
              <a class="link link-primary" href="${rq.loginUri}">로그인</a> 후 이용해주세요.
            </c:if>
          </div>
        </section>

        <section class="mt-5">
          <div class="container mx-auto px-3">
            <h1>댓글 (${replies.size()})</h1>


            <ol class="relative border-l border-gray-200 dark:border-gray-700 mt-2">
              <c:forEach var="reply" items="${replies}">
                <li class="mb-10 ml-6">
                  <span
                    class="flex absolute -left-3 justify-center items-center w-6 h-6 bg-blue-200 rounded-full ring-8 ring-white dark:ring-gray-900 dark:bg-blue-900">
                  </span>
                  <div
                    class="justify-between items-center p-4 bg-white rounded-lg border border-gray-200 shadow-sm sm:flex dark:bg-gray-700 dark:border-gray-600">
                    <time
                      class="mb-1 text-xs font-normal text-gray-400 sm:order-last sm:mb-0">${reply.forPrintType1RegDate}</time>
                    <div class="text-sm font-normal text-gray-500 dark:text-gray-300">${reply.body} <a href="#"
                        class="font-semibold text-blue-600 dark:text-blue-500 hover:underline">${reply.extra__writerName}</a>
                      <span></span>
                    </div>

                  </div>
                  <c:if test="${reply.extra__actorCanModify}">
                    <a class="btn btn-link"
                      href="../reply/modify?id=${reply.id}&replaceUri=${rq.encodedCurrentUri}">수정</a>
                  </c:if>
                  <c:if test="${reply.extra__actorCanDelete}">
                    <a class="btn btn-link" onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;"
                      href="../reply/doDelete?id=${reply.id}&replaceUri=${rq.encodedCurrentUri}">삭제</a>
                  </c:if>
                </li>

              </c:forEach>
            </ol>



          </div>

        </section>
        <%@ include file="../common/foot.jspf" %>