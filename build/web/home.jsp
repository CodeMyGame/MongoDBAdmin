<%-- 
    Document   : home
    Created on : Nov 19, 2016, 11:34:43 AM
    Author     : Kapil Gehlot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/font-awesome.css" rel="stylesheet" type="text/css"/>
        <title>Home</title>
    </head>
    <body>

        <%
            String userName = "";
            if (session.getAttribute("uname") == null) {
                String site = new String("login.html");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else {
                userName = session.getAttribute("uname").toString();
            }
        %>

    <center><h1>Welcome <%=userName%></h1></center>
    <button id="btn-logout" style="position:relative; float: right;right:20px" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-log-out"></i>&nbsp;Logout</button>
    <hr>
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height: 100%">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="border-right: 2px solid #eee">
            <center><h2>Create new Database</h2>
                <input id="db-name" class="form-control" type="text" placeholder="Enter DB name">
                <br>
                <button id="btn-create" class="btn btn-primary btn-block"><span id="login-text"><i class="glyphicon glyphicon-edit"></i>&nbsp;Create</span>
                    <center><img  id="loading" height="23" alt="loading.." src="img/hourglass.gif" style="display: none"></center></button>
                <div id="selected-db" style="display: none">
                    <center><h2 style="position: relative" id="getDbName"></h2></center>

                    <input class="form-control" id="coll-name" type="text" placeholder="Enter Collection name">
                    <br>
                    <button id="btn-createColl" class="btn btn-primary btn-block"><span id="coll-text"><i class="glyphicon glyphicon-edit"></i>&nbsp;Create</span>
                        <center><img  id="loading-coll" height="23" alt="loading.." src="img/hourglass.gif" style="display: none"></center></button><br>
                    <i id="refreshColl" style="cursor: pointer;float: right;position: relative"class="glyphicon glyphicon-refresh"></i>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Collection name</th>
                                <th>Download</th>
                                <th>Delete</th>

                            </tr>
                        </thead>
                        <tbody id="table-tr2">

                        </tbody>
                    </table>
                </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="height: 100%">
            <center><h2>Your Databases</h2></center>
            <i id="refresh" style="cursor: pointer;float: right;position: relative"class="glyphicon glyphicon-refresh"></i>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Database name</th>
                        <th>Date of creation</th>
                        <th>Download</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody id="table-tr">

                </tbody>
            </table>
        </div>
    </div>

    <div class="alert alert-info alert-dismissible col-lg-4 col-md-4 col-sm-6 col-xs-12 " role="alert" id="response" 
         style="position: absolute;margin: auto;bottom:10%;right:0;left: 0;display: none">
    </div> 

    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <center><h4 class="modal-title coll-title" style="color: #fff"></h4></center>
                </div>
                <div class="modal-body">
                    <h4 id="total-doc"></h4>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Document name</th>
                                <th>Date of creation</th>
                                <th>Download</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody id="table-tr-doc">

                        </tbody>
                    </table>
                    <p class="modal-body-p"></p>
                </div>
                <div class="modal-footer">


                    <div class="col-lg-12"><input id="get-doc-name" type="text" class="form-control col-lg-6" placeholder="Enter Doc name">
                    </div><br><br>                                        <div class="col-lg-12">
                        <div class="col-lg-6"><input id="get-data-key"  type="text" class="form-control col-lg-6" placeholder="Enter Key"></div>
                        <div class="col-lg-6"><input id="get-data-value" type="text" class="form-control col-lg-6" placeholder="Enter Value"></div>

                    </div>


                    <br>
                    <br>
                    <br><br>
                    <div class="col-lg-12">
                        <div class="col-lg-4">
                            <center><button title="Insert"  type="button" class="btn bg-info btn-manupulate" style=" width: 160px;height: 35px;  "><i class="glyphicon glyphicon-cloud-upload"></i><span>New Document</span></button></center>
                        </div>
                        <div class="col-lg-4">

                        </div>
                        <div class="col-lg-4">
                            <center><button title="update"  type="button" class="btn bg-info btn-manupulate" style=" width: 160px;height: 35px;"><i class="glyphicon glyphicon-upload"></i><span>Update Document</span></button></center>
                        </div>
                    </div>
                    <br><br>

                </div>
            </div>

        </div>
        <button id="btn-collection" type="button"  data-toggle="modal" data-target="#myModal" style="display: none"></button>
    </div>
    <div style="display: none">
        <form action="DownloadDB" method="POST">
            <input id="input-db" type="text" name="dbname">
            <button type="submit" id="btn-down-db"></button>
        </form>
        <form action="DownloadColl" method="POST">
            <input id="input-coll" type="text" name="collname">
            <input id="input-coll-db" type="text" name="dbname">
            <button type="submit" id="btn-down-coll"></button>
        </form>
        <form action="DownloadDoc" method="POST">
            <input id="input-doc" type="text" name="doc">
            <input id="input-doc-coll" type="text" name="coll">
            <input id="input-doc-db" type="text" name="db">
            <button type="submit" id="btn-down-doc"></button>
        </form>
    </div>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $('#table-tr').html("");
            $.ajax({
                type: 'POST',
                url: "GetDatabase",
                success: function (data, textStatus, jqXHR) {
                    var resp = jqXHR.responseText;
                    // alert(resp);
                    var parse = $.parseJSON(resp);
                    // alert(parse.db[0]);
                    var i = 0;
                    for (i = 0; i < parse.counter; i++) {

                        $('#table-tr').append("<tr><td><b><a href='javascript:void(0)' class='dblink' style='cursor: pointer'>" + parse.db[i].kapil + "</b></a></td>"
                                + "<td><b>" + parse.db[i]._id.date + "</b></td>" + "<td>" + "<i style='cursor:pointer' class='glyphicon glyphicon-download db-download'><span style='display:none'>" + parse.db[i].kapil + "</span></i>" + "</td>"
                                + "<td>" + "<i style='cursor:pointer' class='glyphicon glyphicon-remove mongo-remove'><span style='display:none'>" + parse.db[i].kapil +";db"+ "</span></i>" + "</td>" + "</tr>");
                    }

                }
            });
            $("#btn-logout").click(function () {

                $.ajax({
                    type: 'POST',
                    url: "Logout",
                    success: function (data, textStatus, jqXHR) {
                        var resp = jqXHR.responseText;
                        if (resp === "true") {
                            window.location.replace("login.html");
                        } else if (resp === "false") {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR : Logout Failed");
                        } else {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR :Technical server Problem");
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#response').fadeIn(100);
                        $('#response').fadeOut(4000);
                        $('#response').html("ERROR :Technical server Problem");
                    },
                    beforeSend: function (xhr) {
                        $('#btn-logout').attr("disabled", true);
                    },
                    complete: function (jqXHR, textStatus) {
                        $('#btn-logout').attr("disabled", false);
                    }

                });
            });
            $("#btn-create").click(function () {

                var dbName = $('#db-name').val().trim();
                if (dbName !== '') {
                    var datastringU = 'dbname=' + encodeURIComponent(dbName);
                    $.ajax({
                        type: 'POST',
                        data: datastringU,
                        url: "CreateDB",
                        success: function (data, textStatus, jqXHR) {
                            var resp = jqXHR.responseText;
                            if (resp === "true") {
                                $('#response').html("SUCCESS: Database created successfully.");
                                $('#db-name').val("");
                                $('#response').fadeIn(1);
                                $('#response').fadeOut(4000);
                            } else if (resp === "false") {
                                $('#response').fadeIn(100);
                                $('#response').fadeOut(4000);
                                $('#response').html("ERROR :Database not created ");
                            } else {
                                $('#response').fadeIn(100);
                                $('#response').fadeOut(4000);
                                $('#response').html("ERROR :Technical server Problem");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR :Technical server Problem");
                        },
                        beforeSend: function (xhr) {
                            $('#btn-create').attr("disabled", true);
                            $('#loading').css("display", "block");
                            $('#login-text').css("display", "none");
                        },
                        complete: function (jqXHR, textStatus) {
                            $('#btn-create').attr("disabled", false);
                            $('#loading').css("display", "none");
                            $('#login-text').css("display", "block");
                        }


                    });
                } else {
                    $('#response').html("ERROR:  field empty");
                    $('#response').fadeIn(10);
                    $('#response').fadeOut(4000);
                }

            });
            $("#btn-createColl").click(function () {

                var collName = $('#coll-name').val().trim();
                var dbName = $('#getDbName').text();
                if (dbName !== '') {
                    var datastringU = 'dbname=' + encodeURIComponent(dbName) + '&' + 'collname=' + encodeURIComponent(collName);
                    $.ajax({
                        type: 'POST',
                        data: datastringU,
                        url: "CreateColl",
                        success: function (data, textStatus, jqXHR) {
                            var resp = jqXHR.responseText;
                            if (resp === "true") {
                                $('#response').html("SUCCESS: Collection created successfully.");
                                $('#coll-name').val("");
                                $('#response').fadeIn(1);
                                $('#response').fadeOut(4000);
                            } else if (resp === "false") {
                                $('#response').fadeIn(100);
                                $('#response').fadeOut(4000);
                                $('#response').html("ERROR :Collection not created ");
                            } else {
                                $('#response').fadeIn(100);
                                $('#response').fadeOut(4000);
                                $('#response').html("ERROR :Technical server Problem");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR :Technical server Problem");
                        },
                        beforeSend: function (xhr) {
                            $('#btn-createColl').attr("disabled", true);
                            $('#loading-coll').css("display", "block");
                            $('#coll-text').css("display", "none");
                        },
                        complete: function (jqXHR, textStatus) {
                            $('#btn-createColl').attr("disabled", false);
                            $('#loading-coll').css("display", "none");
                            $('#coll-text').css("display", "block");
                        }


                    });
                } else {
                    $('#response').html("ERROR:  field empty");
                    $('#response').fadeIn(10);
                    $('#response').fadeOut(4000);
                }

            });
            $("#refresh").click(function () {
                $('#table-tr').html("");
                $.ajax({
                    type: 'POST',
                    url: "GetDatabase",
                    success: function (data, textStatus, jqXHR) {
                        var resp = jqXHR.responseText;
                        // alert(resp);
                        var parse = $.parseJSON(resp);
                        // alert(parse.db[0]);
                        var i = 0;
                        for (i = 0; i < parse.counter; i++) {

                            $('#table-tr').append("<tr><td><b><a href='javascript:void(0)' class='dblink' style='cursor: pointer'>" + parse.db[i].kapil + "</b></a></td>"
                                    + "<td><b>" + parse.db[i]._id.date + "</b></td>" + "<td>" + "<i style='cursor:pointer' class='glyphicon glyphicon-download db-download'><span style='display:none'>" + parse.db[i].kapil + "</span></i>" + "</td>"
                                    + "<td>" + "<i style='cursor:pointer' class='glyphicon glyphicon-remove mongo-remove'><span style='display:none'>" + parse.db[i].kapil +";db"+ "</span></i>" + "</td>" + "</tr>");
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#response').fadeIn(100);
                        $('#response').fadeOut(4000);
                        $('#response').html("ERROR :Technical server Problem");
                    }


                });
            });
            $('body').on("click", 'a.dblink', function () {
                var dbName = $(this).text();
                $('#selected-db').css("display", "block");
                $('#getDbName').html(dbName);
                $('#table-tr2').html("");
                if (dbName !== '') {
                    var datastringU = 'dbname=' + encodeURIComponent(dbName);
                    $.ajax({
                        type: 'POST',
                        data: datastringU,
                        url: "DBInformation",
                        success: function (data, textStatus, jqXHR) {
                            var resp = jqXHR.responseText;
                            var parse = $.parseJSON(resp);
                            var i = 0;
                            for (i = 0; i < parse.counter; i++) {

                                $('#table-tr2').append("<tr><td><b><a href='javascript:void(0)' class='collectionlink' style='cursor: pointer'>" + parse.db[i] + "</b></a></td>"
                                        + "<td><i style='cursor:pointer' class='glyphicon glyphicon-download coll-download'><span style='display:none'>" + parse.db[i] + "</span></i></td>"
                                        + "<td><i style='cursor:pointer' class='glyphicon glyphicon-remove mongo-remove'><span style='display:none'>" + parse.db[i] +";coll"+ "</span></i></td>" + "</tr>");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR :Technical server Problem");
                        }

                    });
                }
            });
            $('body').on("click", 'a.doclink', function () {
                //alert("Perform download");
                var doc = $(this).text();
                var db = $('#getDbName').text();
                var coll = $('.coll-title').text();
                var datastringU = 'doc=' + encodeURIComponent(doc)
                        + '&' + 'coll=' + encodeURIComponent(coll)
                        + '&' + 'db=' + encodeURIComponent(db);
                $.ajax({
                    type: 'POST',
                    data: datastringU,
                    url: "DownloadDoc",
                    success: function (data, textStatus, jqXHR) {
                        var resp = jqXHR.responseText;
                        alert(resp);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#response').fadeIn(100);
                        $('#response').fadeOut(4000);
                        $('#response').html("ERROR :Technical server Problem");
                    }
                });

            });
            $('body').on("click", 'a.collectionlink', function () {
                var collName = $(this).text();
                var dbName = $('#getDbName').text();
                $('.modal-title').html(collName);
                $('#table-tr-doc').html("");
                if (dbName !== '') {
                    var datastringU = 'dbname=' + encodeURIComponent(dbName) + '&' + 'collname=' + encodeURIComponent(collName);
                    $.ajax({
                        type: 'POST',
                        data: datastringU,
                        url: "CollInformation",
                        success: function (data, textStatus, jqXHR) {
                            var resp = jqXHR.responseText;
                            var parse = $.parseJSON(resp);
                            $('#total-doc').html("Total documents = " + parse.totalDoc);
                            for (i = 0; i < parse.counter; i++) {

                                $('#table-tr-doc').append("<tr><td><b><a href='javascript:void(0)' class='doclink' style='cursor: pointer'>" + parse.db[i].name + "</b></a></td>"
                                        + "<td><b>"
                                        + parse.db[i]._id.date + "</b></td>" + "<td><i style='cursor:pointer' class='glyphicon glyphicon-download doc-download'><span style='display:none'>" + parse.db[i].name + "</span></i></td>"
                                        + "<td><i style='cursor:pointer' class='glyphicon glyphicon-remove mongo-remove'><span style='display:none'>" + parse.db[i].name +";doc"+"</span></i></td>" + "</tr>");
                            }
                            $('#btn-collection').click();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR :Technical server Problem");
                        }
                    });
                }
            });
            $('.btn-manupulate').click(function () {
                var dataDoc = $('#get-doc-name').val().trim();
                var dbName = $('#getDbName').text();
                var collName = $('.modal-title').text();
                var uniquekey = $(this).text();
                var datakey = $('#get-data-key').val();
                var dataval = $('#get-data-value').val();
                if (dataDoc !== '') {
                    var datastringU = 'doc=' + encodeURIComponent(dataDoc)
                            + '&' + 'coll=' + encodeURIComponent(collName)
                            + '&' + 'db=' + encodeURIComponent(dbName)
                            + '&' + 'ukey=' + encodeURIComponent(uniquekey)
                            + '&' + 'dockey=' + encodeURIComponent(datakey)
                            + '&' + 'docval=' + encodeURIComponent(dataval);
                    $.ajax({
                        type: 'POST',
                        data: datastringU,
                        url: "ManupulateData",
                        success: function (data, textStatus, jqXHR) {
                            var resp = jqXHR.responseText;
                            if (resp === "true") {
                                alert("Success");
                                $('#get-doc-name').val("");
                                $('#get-data-key').val("");
                                $('#get-data-value').val("");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#response').fadeIn(100);
                            $('#response').fadeOut(4000);
                            $('#response').html("ERROR :Technical server Problem");
                        }

                    });
                } else {
                    $('#response').html("ERROR:  field empty");
                    $('#response').fadeIn(10);
                    $('#response').fadeOut(4000);
                }

            }
            );
            $('body').on("click", 'i.db-download', function () {
                var db = $(this).text();
                $('#input-db').val(db);
                $('#btn-down-db').click();
            });
            $('body').on("click", 'i.coll-download', function () {
                var coll = $(this).text();

                var db = $('#getDbName').text();
                $('#input-coll-db').val(db);
                $('#input-coll').val(coll);
                $('#btn-down-coll').click();

            });
            $('body').on("click", 'i.doc-download', function () {
                var doc = $(this).text();
                var db = $('#getDbName').text();
                var coll = $('.coll-title').text();
                $('#input-doc-db').val(db);
                $('#input-doc-coll').val(coll);
                $('#input-doc').val(doc);
                $('#btn-down-doc').click();
            });
            $('body').on("click", 'i.mongo-remove', function () {
                var respective = $(this).text();
                var db = $('#getDbName').text();
                var coll = $('.coll-title').text();
                var datastringU = 'respective=' + encodeURIComponent(respective)
                        + '&' + 'collname=' + encodeURIComponent(coll)
                        + '&' + 'dbname=' + encodeURIComponent(db);
                $.ajax({
                    type: 'POST',
                    data: datastringU,
                    url: "ManupulateMongo",
                    success: function (data, textStatus, jqXHR) {
                        var resp = jqXHR.responseText;
                       alert(resp);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#response').fadeIn(100);
                        $('#response').fadeOut(4000);
                        $('#response').html("ERROR :Technical server Problem");
                    }

                });

            });
        });

    </script>
</body>
</html>
