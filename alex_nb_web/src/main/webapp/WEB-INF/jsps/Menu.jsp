<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Головне меню</title>
    <script src="js/jquery-1.11.1.js"></script>
    <script>
        $(document).ready(function () {
            $('#search_img').click(function(){
                window.open("assetsSearch")
            });
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
        #b0{
            display: table;
            height: 80px;
            width: 100%;
            color: white;
            background-color: #205081;
        }
        #b0 div{
            width: 33%;
            display: table-cell;
        }
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
            /*background-image: url(images/menu.jpg);*/
            background-size: 100%;
            background-color: lightblue;
        }
        .menuBlock button{
            width: 200px;
            height: 60px;
            font-size: 35px;
            font-weight: bolder;
        }
        .menuBlock div{
            height: 120px;
            padding: 5% 0;
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
        #search_img{
            width: 80px;
            height: 50px;
        }
        #search_img:hover{
            cursor: pointer;
            width: 82px;
            height: 52px;
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
        .menuImg{
            padding-left: 5%;
            padding-right: 5%;
            width: 120px;
            height: 90px;
        }
        .menuImg:hover{
            cursor: pointer;
            width: 130px;
            height: 100px;
        }
    </style>
</head>

<body id="bd">
<header id="b0">
    <div>
        Вітаємо, ${userId} !
    </div>
    <div>
        <h1 align="center">ГОЛОВНЕ МЕНЮ</h1>
    </div>
    <div></div>
</header>

<div class="menuBlock" align="center">
    <div id="headButBlock">
        <%--<img class="menuImg" src="images/menu/lot.jpg" onclick="location.href = 'lotMenu'" title="ЛОТИ">
        <img class="menuImg" src="images/menu/bid.jpg" onclick="location.href = 'bidMenu'" title="ТОРГИ">
        <img class="menuImg" src="images/menu/ex.jpg" onclick="location.href = 'exMenu'" title="БІРЖІ">--%>
        <button id="lotBut" onclick="location.href = 'notSoldedLotMenu'">Лоти</button>
        <button id="bidBut" onclick="location.href = 'bidMenu'">Аукціони</button>
        <button id="exBut" onclick="location.href = 'exMenu'">Біржі</button>
    </div>
    <div id="objButBlock">
        <%--<img id="assButt" class="menuImg" src="images/menu/assets.jpg" title="Відкрити список матеріальних активів">
        <img id="crdButt" class="menuImg" src="images/menu/credits.jpg" title="Відкрити список кредитів">--%>
        <img id="search_img" src="images/search.png" title="пошук об'єктів">
        <button id="assButt">Об'єкти</button>
        <button id="crdButt">Кредити</button>
    </div>
    <div id="repButBlock">
        <img id="reportsButton" src="images/reports.png" onclick="location.href = 'reports'" title="Перейти до завантаження звітів щодо проведених аукціонів"/>
    </div>
</div>
<div id="infoBlock">
<%--<h3>
    Останні оновлення
</h3>
    <ul>
        <li>Додано редагування Затвердженої ФГВФО ціни об'єктів у вкладці РЕДАГУВАННЯ ЛОТУ</li>
        <li>Додано можливість редагування Початкової ціни лоту(від якої розраховується дисконт)</li>
    </ul>--%>
</div>

</body>
</html>