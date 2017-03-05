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
import com.mongodb.MongoClient;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Kapil Gehlot
 */
public class DownloadDoc extends HttpServlet {

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

            String getDBName = request.getParameter("db");
            String getCollName = request.getParameter("coll");
            String getDocName = request.getParameter("doc");
           // out.print(getCollName+getDBName+getDocName);
            MongoClient mongoClient = new MongoClient("localhost", 27017);
            DB mongoDatabase = mongoClient.getDB(getDBName);
            DBCollection coll = mongoDatabase.getCollection(getCollName);
            BasicDBObject basicDBObject = new BasicDBObject();
            basicDBObject.put("name", getDocName);
            DBCursor cursor = coll.find(basicDBObject);
            JSONObject jSONObject = new JSONObject();
            JSONArray jSONArray = new JSONArray();
            while (cursor.hasNext()) {
                jSONArray.put(cursor.next());
            }
            String filename = getDBName+"_"+getCollName+"_"+getDocName+ ".json";
            jSONObject.put(getCollName, jSONArray);
            File file = checkExist("mongodoc.json");
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(jSONObject.toString());
            fileWriter.flush();
            fileWriter.close();
         
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
            FileInputStream fis = new FileInputStream(dir + "\\" +"mongodoc.json");
            int i;
            while ((i = fis.read()) != -1) {
                out.write(i);

            }
            fis.close();
            out.close();

        } catch (JSONException ex) {
            Logger.getLogger(DownloadDoc.class.getName()).log(Level.SEVERE, null, ex);
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
