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
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Kapil Gehlot
 */
public class CreateColl extends HttpServlet {
 public boolean collectionExists(String name, DB db) {
        Set<String> collNames = db.getCollectionNames();
        for (final String n : collNames) {
            if (n.equalsIgnoreCase(name)) {
                return true;
            }
        }
        return false;
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
            String getDBName = request.getParameter("dbname");
            String getCollName = request.getParameter("collname");
            MongoClient mongoClient = new MongoClient("localhost", 27017);
            DB mongoDatabase = mongoClient.getDB(getDBName);
            DBObject bObject = new BasicDBObject();
            bObject.put(getDBName, getCollName);
            if(!collectionExists(getDBName, mongoDatabase)){
               mongoDatabase.createCollection(getCollName,bObject);
                //BasicDBObject doc = new BasicDBObject();
               // doc.put("name",getCollName);
              //  dBCollection.insert(doc);
                out.print("true");
            }else{
                out.print("false");
            }
      
        } catch (Exception e) {

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
