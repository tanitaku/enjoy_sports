package controllers.posts;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Post;

/**
 * Servlet implementation class PostsNewServlet
 */
@WebServlet("/posts/new")
public class PostsNewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostsNewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.setAttribute("_token", request.getSession().getId());

        // 新規ポストを登録する際に、今日の日付を登録しておく。

        Post p = new Post();
        p.setPost_date(new Date(System.currentTimeMillis()));
        request.setAttribute("post", p);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/posts/new.jsp");
        rd.forward(request, response);
    }

}
