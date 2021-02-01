<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
         </c:if>

         <h2>ユーザー　一覧</h2>&nbsp;
         <a href="<c:url value='/follower' />" class="btn btn--orange">フォロワー</a>>&nbsp;&nbsp;

            <form method="Post" action="<c:url value='/search/user' />" class="search_container">
              <input type="text" name="addres" size="25" placeholder="都道府県検索">
              <input type="submit" value="検索">
            </form>&nbsp;&nbsp;

            <c:if test="${ad != null}">
                <table id="user_list2">
                    <tbody>
                        <tr>
                            <th>ユーザー名</th>
                            <th>都道府県</th>
                            <th>フォロー</th>
                            <th>詳細</th>
                        </tr>
                        <c:forEach var="user" items="${ad}">
                            <tr class="row${status.count % 2}">
                                <td>
                                   <c:out value="${user.user_name}" />
                                </td>
                                <td>
                                   <c:out value="${user.addres}" />
                                </td>
                                 <td>
                                    <c:if test="${user.id != user_id}">
                                        <a href="<c:url value='/follow?id=${user.id}' />">フォローする</a>
                                    </c:if>
                               </td>
                               <td>
                                    <c:if test="${user.id != user_id}">
                                <a href="<c:url value='/profile/show?id=${user.id}' />">詳細</a>
                                    </c:if>
                               </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                  </table>

                    <div id="pagination">
                        （全 ${search_count} 人) <br />
                    </div>
            </c:if>

        <c:if test="${ad == null}">
         <table id="user_list2">
            <tbody>
                <tr>
                    <th>ユーザー名</th>
                    <th>都道府県</th>
                    <th>フォロー</th>
                    <th>詳細</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr class="row${status.count % 2}">
                        <td>
                           <c:out value="${user.user_name}" />
                        </td>
                        <td>
                           <c:out value="${user.addres}" />
                        </td>
                        <td>
                            <c:if test="${user.id != user_id}">
                                <a href="<c:url value='/follow?id=${user.id}' />">フォローする</a>
                            </c:if>
                       </td>
                       <td>
                            <c:if test="${user.id != user_id}">
                        <a href="<c:url value='/profile/show?id=${user.id}' />">詳細</a>
                            </c:if>
                       </td>
                    </tr>
                </c:forEach>
            </tbody>
          </table>


          <div id="pagination">
            （全 ${users_count} 人) <br />
            <c:forEach var="i" begin="1" end="${((users_count - 1) / 15) + 1}" step="1">
            <c:choose>
                <c:when test="${i == page}">
                    <c:out value="${i}" />&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/users/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                </c:otherwise>
            </c:choose>
         </c:forEach>
         </div>
       </c:if>
          </c:param>
       </c:import>
       <p><a href="<c:url value='/users/index' />">一覧に戻る</a></p>
