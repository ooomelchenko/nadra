<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Головне меню</title>
    <script src="js/jquery-1.11.1.js"></script>
    <script>
        $(document).ready(function () {
            $('#assButt').click(function(){
                window.open("assets")
            });
            $('#crdButt').click(function(){
                window.open("credits")
            });
        })
    </script>
    <%-- <link href="css/nbStyle1.css" rel="stylesheet" type="text/css"> --%>
    <style type="text/css">
        button:hover{
            cursor: pointer;
        }
        #reportsButton{
            width: 80px;
            height: 60px;
        }
        #reportsButton:hover{
            cursor: pointer;
            width: 90px ;
            height: 70px;
        }
        body{
            background-image: url(images/menu.jpg);
            background-size: 100%;
        }
        .menu-button button{
            width: 160px;
            height: 50px;
            font-size: 30px;
            font-weight: bolder;
        }
        .menu-button div{
            height: 70px;
        }
        #lotBut:hover{
            border: double cyan;
            color: cyan;
        }
        #bidBut:hover{
            border: double sandybrown;
            color: sandybrown;
        }
        #exBut:hover{
            border: double darkblue;
            color: darkblue;
        }
        #assButt:hover{
            border: double darkgreen;
            color: darkgreen;
        }
        #crdButt:hover{
            border: double blue;
            color: blue;
        }
        #infoBlock{
            position: absolute;
            bottom: 0;
            width: 500px;
            height: 200px;
            font-size: large;
            font-weight: bold;
            font-style: italic;
            color: darkblue;
        }
    </style>
</head>

<body id="bd">
<div id="b0">
    <h2>Вітаємо, ${userId} !</h2>
    <h1 align="center"> ГОЛОВНЕ МЕНЮ </h1>
</div>
<div class="menu-button" align="center">
    <div id="headButBlock">
        <button id="lotBut" onclick="location.href = 'lotMenu'">Лоти</button>
        <button id="bidBut" onclick="location.href = 'bidMenu'">Аукціони</button>
        <button id="exBut" onclick="location.href = 'exMenu'">Біржі</button>
    </div>
    <div id="objButBlock">
        <button id="assButt">Об'єкти</button>
        <button id="crdButt">Кредити</button>
    </div>
    <div id="repButBlock">
        <img id="reportsButton" src="images/reports.png" onclick="location.href = 'reports'" title="Перейти до завантаження звітів щодо проведених аукціонів"/>
    </div>
</div>
<div id="infoBlock">
<h3>
    Останні оновлення
</h3>
    <ul>
        <li>Додано можливість редагування Початкової ціни лоту(від якої розраховується дисконт)</li>
    </ul>
</div>


</body>
</html>