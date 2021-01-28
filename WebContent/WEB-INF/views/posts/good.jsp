<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>

        <h2>ポスト　一覧</h2>
            <table id="post_list">
            <tbody>
                <tr>
                    <th class="post_user_name">ユーザーネーム</th>
                    <th class="post_date">日付</th>
                    <th class="post_title">タイトル</th>
                    <th class="post_action">操作</th>
                </tr>
                <c:forEach var="post" items="${posts}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="post_user_name"><c:out value="${post.user.user_name}" /></td>
                        <td class="post_date"><fmt:formatDate value='${post.post.post_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="post_title">${post.post.brand}</td>
                        <td class="post_action"><a href="<c:url value='/posts/show?id=${post.post.id}' />">詳細を見る</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </c:param>
</c:import>