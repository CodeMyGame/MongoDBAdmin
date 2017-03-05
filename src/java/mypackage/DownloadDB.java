/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mypackage;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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
public class DownloadDB extends HttpServlet {

    String dir = "C:\\Users\\Kapil Gehlot\\Documents";

    private File checkExist(String fileName) {

        File f = new File(dir + "\\" + fileName);
        if (f.exists()) {
            f.delete();
        }
        return f;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
// To connect to mongodb server
                MongoClient mongoClient = new MongoClient("localhost", 27017);
// Now connect to your databases

                String dbname = request.getParameter("dbname");
     
                DB db = mongoClient.getDB(dbname);
                Set<String> collNames = db.getCollectionNames();
                Iterator<String> iterator = collNames.iterator();
                JSONObject jSONObject_db = new JSONObject();
                JSONObject jSONObject_coll = new JSONObject();
                JSONArray jSONObject_doc = new JSONArray();
                
                while (iterator.hasNext()) {
                    String next = iterator.next();
                    DBCollection dBCollection = db.getCollection(next);
                    DBCursor dBCursor = dBCollection.find();
                    while (dBCursor.hasNext()) {
                        DBObject next1 = dBCursor.next();
                        jSONObject_doc.put(next1);

                    }
                    jSONObject_coll.put(next, jSONObject_doc);

                }
                String filename = dbname + ".json";
                jSONObject_db.put(dbname, jSONObject_coll);
                File file = checkExist("mongodb.json");
                FileWriter fileWriter = new FileWriter(file);
                fileWriter.write(jSONObject_db.toString());
                fileWriter.close();
                response.setContentType("APPLICATION/OCTET-STREAM");
                response.setHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
                FileInputStream fis = new FileInputStream(dir + "\\" +"mongodb.json");
                int i;
                while ((i = fis.read()) != -1) {
                    out.write(i);

                }
                fis.close();
                out.close();
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
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
