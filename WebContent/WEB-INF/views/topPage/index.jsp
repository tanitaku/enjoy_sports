<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>Enjoy Sportsへようこそ</h2>
        <h2>本日の日付 <fmt:formatDate value='${date}' pattern='yyyy-MM-dd' /></h2>

        <table id="post_list">
            <tbody>
                <tr>
                    <th class="post_name">氏名</th>
                    <th class="post_date">日付</th>
                    <th class="post_title">タイトル</th>
                    <th class="post_action">操作</th>
                </tr>
                <c:forEach var="post" items="${posts}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="post_name"><c:out value="${post.user.name}" /></td>
                        <td class="post_date"><fmt:formatDate value='${post.post_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="post_title">${post.title}</td>
                        <td class="post_action"><a href="<c:url value='/posts/show?id=${post.id}' />">詳細を見る</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${posts_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((posts_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/posts/new' />">新規ポストの投稿</a></p>
    </c:param>
</c:import>