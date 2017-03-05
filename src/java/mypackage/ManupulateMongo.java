/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mypackage;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Kapil Gehlot
 */
public class ManupulateMongo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String respective = request.getParameter("respective");
            String db = request.getParameter("dbname");
            String coll = request.getParameter("collname");
            String sb = respective;
            int index = sb.indexOf(";");
            int length = respective.length();
            String key = sb.substring(index + 1, length);
            HttpSession session = request.getSession(false);
            MongoClient mongoClient = new MongoClient("localhost", 27017);

            if (key.equals("db")) {
                String dbname = respective.substring(0,index);
                String coll_personal = session.getAttribute("uname")+"DB";
                DB mongodb = mongoClient.getDB(dbname);
                DB mongodb_personal = mongoClient.getDB("mydb");
                mongodb.dropDatabase();
                DBCollection dBCollection = mongodb_personal.getCollection(coll_personal);
                BasicDBObject query = new BasicDBObject();
                query.put("kapil",dbname);
                dBCollection.remove(query);
                out.print("true");
            }
            if (key.equals("coll")) {
                String collname = respective.substring(0,index);
                DB mongodb = mongoClient.getDB(db);
                DBCollection dBCollection = mongodb.getCollection(collname);
                dBCollection.drop();
                
                out.print("true");
            }
            if (key.equals("doc")) {
                String docname = respective.substring(0,index);
                DB mongodb = mongoClient.getDB(db);
                DBCollection dBCollection = mongodb.getCollection(coll);
                BasicDBObject query = new BasicDBObject();
                query.put("name",docname);
                dBCollection.remove(query);
                out.print("true");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
