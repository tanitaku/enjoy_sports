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
 * Servlet implementation class PostsShowServlet
 */
@WebServlet("/posts/show")
public class PostsShowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostsShowServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        EntityManager em = DBUtil.createEntityManager();

        Post p = em.find(Post.class, Integer.parseInt(request.getParameter("id")));

        User i2 = p.getUser();





//        // 質問者と回答者のデータがあれば、取得
//        try {
//           List<Comment> q = em.createNamedQuery("checkAnswer", Comment.class)
//                  .setParameter("answer", i2)
//                  .getResultList();
//           request.setAttribute("comment", q);
//
//            } catch(NoResultException ex) {}

        em.close();

        request.setAttribute("post", p);
        request.setAttribute("_token", request.getSession().getId());
        if(request.getSession().getAttribute("flush") != null) {
            request.setAttribute("flush", request.getSession().getAttribute("flush"));
            request.getSession().removeAttribute("flush");
        }

        if(request.getSession().getAttribute("errors") != null) {
            request.setAttribute("errors", request.getSession().getAttribute("errors"));
            request.getSession().removeAttribute("errors");
        }


        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/posts/show.jsp");
        rd.forward(request, response);
    }

}