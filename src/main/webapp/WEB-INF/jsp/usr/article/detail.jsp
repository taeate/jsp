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

            <div class="p-5 mb-4 bg-gray-50 rounded-lg border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
              <div class="container flex justify-between">
                <div class="flex text-center">
                  <div class="text-lg font-semibold text-gray-900 dark:text-white">${article.title}</div>
                  <div class="text-base m-auto text-blue-600 ml-4">${article.extra__writerName}</div>
                  <div class="ml-2 m-auto text-sm text-gray-500">${article.forPrintType2RegDate}</div>
                  <div class="ml-4 m-auto"><i class="fa-solid fa-eye"></i>
                    <span>${article.hitCount}</span>
                  </div>
                  <div class="ml-6 m-auto">
                    <i class="fa-solid fa-thumbs-up"></i>
                    ${article.goodReactionPoint}
                  </div>
                </div>
                <c:if test="${article.extra__actorCanModify}">
                  <div class="ml-4">
                    <button>
                      <div class="dropdown dropdown-left">
                        <i class="fa-solid fa-ellipsis-vertical fa-1x" tabindex="0"></i>
                        <ul tabindex="0" class="dropdown-content menu p-2 shadow bg-base-100 rounded-box w-52">
                          <li>
                            <a href="../article/modify?id=${article.id}">게시물 수정</a>
                          </li>
                          <li>
                            <c:if test="${article.extra__actorCanDelete}">
                              <a onclick="if ( confirm('정말 삭제하시겠습니까?') == false ) return false;"
                                href="../article/doDelete?id=${article.id}">게시물 삭제</a>
                            </c:if>
                          </li>
                        </ul>
                      </div>
                    </button>
                  </div>
                </c:if>
              </div>
              <ol class="mt-3 divide-y divider-gray-200 dark:divide-gray-700">
                <a href="#" class="block items-center p-3 sm:flex hover:bg-gray-100 dark:hover:bg-gray-700">


                  <div class="text-gray-600 dark:text-gray-400">
                    <div class="text-lg font-normal"><span class="text-lg text-gray-900 dark:text-white">
                        <div class="toast-ui-viewer">
                          <script type="text/x-template">
                        ${article.body}
                        </script>
                        </div>
                    </div>
                  </div>
                </a>
              </ol>
              <div class="mt-4 flex justify-end">
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
            </div>

            <div class="btns">
              <c:if test="${empty param.listUri}">
                <button class="btn btn-link" type="button" onclick="history.back();">뒤로가기</button>
              </c:if>
              <c:if test="${not empty param.listUri}">
                <a class="btn btn-link" href="${param.listUri}">뒤로가기</a>
              </c:if>
            </div>
            <hr class="mt-4">
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
                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-400 mt-4">${rq.loginedMember.nickname}</label>
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