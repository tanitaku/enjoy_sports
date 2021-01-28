package controllers.posts;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Post;
import models.User;
import utils.DBUtil;

/**
 * Servlet implementation class PostsEditServlet
 */
@WebServlet("/posts/edit")
public class PostsEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostsEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        EntityManager em = DBUtil.createEntityManager();

        Post p = em.find(Post.class, Integer.parseInt(request.getParameter("id")));

        em.close();

        User login_user = (User)request.getSession().getAttribute("login_user");
        if(p != null && login_user.getId() == p.getUser().getId()) {
            request.setAttribute("post", p);
            request.setAttribute("_token", request.getSession().getId());
            request.getSession().setAttribute("post_id", p.getId());
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/posts/edit.jsp");
        rd.forward(request, response);

    }

}
