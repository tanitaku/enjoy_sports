<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${post != null}">
            <c:if test="${flush != null}">
                <div id="flush_success">
                    <c:out value="${flush}"></c:out>
                </div>
            </c:if>
            <c:if test="${errors != null}">
                <div id="flush_error">
                    入力内容にエラーがあります。<br />
                        <c:forEach var="error" items="${errors}">
            ・               <c:out value="${error}" /><br />
                        </c:forEach>

                </div>
            </c:if>
                <h2>ポスト　詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>タイトル</th>
                            <td><c:out value="${post.title}" />
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <tr>
                            <th>ユーザー名</th>
                            <td><c:out value="${post.user.user_name}" /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${item.content}" /></pre>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <h1>コメント一覧</h1>

                <c:choose>
                    <c:when test="${sessionScope.login_user.id == post.user.id}">

                         <c:forEach var="comments" items="${comment}">
                            <p>ID:<c:out value="${comments.id}"/>　名前:<c:out value="${comments.user.user_name}"/>　日付:<c:out value="${comments.time}"/><br>
                            <c:out value="${comments.comment}"/></p>
                         </c:forEach>

                         <form method="POST" action="<c:url value="/question?id=${post.id}" />">
                            <p>コメント:<br>
                            <textarea name="comment" rows="5" cols="40"></textarea>
                            </p>
                            <p><input type="submit" value="送信"></p>
                         </form>

                         <p><a href="<c:url value="/posts/edit?id=${post.id}" />">ポストを編集する</a></p>
                         <form method="POST" action="<c:url value='/posts/destroy?id=${post.id}"' />">
                             <input type="hidden" name="_token" value="${_token}" />
                             <button type="submit">ポストを削除する</button>
                         </form>
                    </c:when>
                <c:otherwise>

                    <c:forEach var="comments" items="${comment}">
                    <c:choose>
                    <c:when test="${comments.post.id == post.id}" >
                            <p>ID:<c:out value="${comments.id}"/>　名前:<c:out value="${comments.user.user_name}"/>　日付:<c:out value="${comments.time}"/><br>
                                <c:out value="${comments.comment}"/></p>
                    </c:when>
                    </c:choose>
                     </c:forEach>

                    <form method="POST" action="<c:url value="/question?id=${post.id}" />">
                        <p>コメント:<br>
                        <textarea name="comment" rows="5" cols="40" placeholder="${post.user.user_name}さんへ"></textarea>
                        </p>
                        <p><input type="submit" value="送信"></p>
                    </form>

                    <c:if test="${sessionScope.login_user.id == post.user.id}">
                        <p><a href="<c:url value="/posts/edit?id=${post.id}" />">ポストを編集する</a></p>
                            <form method="POST" action="<c:url value='/posts/destroy?id=${post.id}"' />">
                                <input type="hidden" name="_token" value="${_token}" />
                                <button type="submit">ポストを削除する</button>
                            </form>
                    </c:if>
                </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>
        <p><a href="<c:url value="/posts/index" />">一覧に戻る</a></p>
    </c:param>
</c:import>

