/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mypackage;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Kapil Gehlot
 */
public class ManupulateData extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String ukey = request.getParameter("ukey");
            String docname = request.getParameter("doc");
            String db = request.getParameter("db");
            String coll = request.getParameter("coll");

            MongoClient mongoClient = new MongoClient("localhost", 27017);
            DB mongoDatabase = mongoClient.getDB(db);
            DBCollection dbcoll = mongoDatabase.getCollection(coll);
            if (ukey.equals("Update Document")) {
                String key = request.getParameter("dockey");
                String value = request.getParameter("docval");
                BasicDBObject basicDBObject = new BasicDBObject();
                basicDBObject.append("$set", new BasicDBObject().append(key, value));
                BasicDBObject serchQuery = new BasicDBObject("name", docname);
                dbcoll.update(serchQuery, basicDBObject);
                out.print("true");

            }
            if (ukey.equals("New Document")) {
                BasicDBObject bObject = new BasicDBObject("name", docname);
                dbcoll.insert(bObject);
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
