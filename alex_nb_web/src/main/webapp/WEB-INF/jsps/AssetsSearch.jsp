<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Пошук об'єктів</title>
    <link rel="stylesheet" media="screen" type="text/css" href="css/lotCreatorStyle.css"/>
    <script src="js/jquery-1.11.1.js"></script>
    <script>
        $(document).ready(function () {
            var ftab = $('.findTab');

            function addToFindTab(obj) {
                $('.findTab').find('.ftr').remove();
                ftab.show();

                for (var i = 0; i < obj.length; i++) {

                    var approveNBU = obj[i].approveNBU ? "Так" : "Ні";
                    var lotId="";
                    var bidDate="";
                    var exName="";

                    if(obj[i].lot!= null){
                        lotId=obj[i].lot.id;
                        if(obj[i].lot.bid!=null){
                            bidDate = new Date(obj[i].lot.bid.bidDate).toLocaleDateString();

                            exName= obj[i].lot.bid.exchange.companyName;
                        }
                    }

                    var tr = $('<tr class="ftr" align="center">' +
                        '<td class="idObj">' + obj[i].id + '</td>' +
                        '<td>' + lotId + '</td>' +
                        '<td>' + obj[i].inn + '</td>' +
                        '<td>' + obj[i].asset_name + '</td>' +
                        '<td>' + obj[i].asset_descr + '</td>' +
                        '<td>' + obj[i].region + '</td>' +
                        '<td>' + obj[i].zb + '</td>' +
                        '<td>' + obj[i].rv + '</td>' +
                        '<td>' + approveNBU + '</td>' +
                        '<td>' + bidDate + '</td>' +
                        '<td>' + exName + '</td>' +
                        '</tr>');
                    ftab.append(tr);
                }
            }

            $('#findObjBut').on('click', function () {

                $.ajax({
                    url: "allObjectsByInNum",
                    method: "POST",
                    data: {inn: $('#inn').val()},
                    success(obj){
                        addToFindTab(obj);
                    }
                });
            });

            $('#formDownld').click(function(){
                window.open("downLotIdListForm");
            });

            $('#sendBut').click(function(){
                sendFile();
            });

            function sendFile(){
                var formData = new FormData($('form')[0]);
                $.ajax({
                    type: "POST",
                    processData: false,
                    contentType: false,
                    url: "uploadIdFile",
                    data:  formData,
                    success: function (obj) {
                        addToFindTab(obj);
                    }
                })
            }

        });
    </script>

</head>

<body style="background-color: mintcream">
<div id="b0">
    <button onclick="location.href='index'">Назад</button>
    <H1 align="center">Пошук об'єктів</H1>
</div>

<div id="mainBlock">

    <div id="searchBlock" class="choice-box">

        <div>
            <table style="width: 100%">
                <tr>
                    <td>
                        <input id="inn" type="text" placeholder="Введіть ІНН для пошуку" style="width: 100%">
                    </td>
                </tr>
                <tr>
                    <td>
                        <button id="findObjBut" class="button" style="width: 100%">Знайти</button>
                    </td>
                </tr>
            </table>
        </div>

    </div>
    <div id="listSearchBlock">
        <form method="POST" action="" enctype="multipart/form-data" lang="utf8">
            <h3>Обрати файл з Інвентарними номерами:</h3>
            <input align="center" type="file" name="file" title="натисніть для обрання файлу"><br/>
            <input name="idType" value="1" type="number" hidden="hidden">
        </form>
        <button id="sendBut">Знайти по списку з файлу</button>
    </div>
    <div style="width: 10%">
        <button id="formDownld" title="Завантажити зразок файлу зі списком ID для пошуку">форма(.xls)</button>
    </div>
</div>
<br/>
<div class="view">
    <table class="findTab" border="2" hidden="hidden">
        <tr align="center" style="background-color: #27d927">
            <th>ID</th>
            <th>Лот</th>
            <th>Інвентарний №</th>
            <th>Назва активу</th>
            <th>Опис об'єкту</th>
            <th>Регіон</th>
            <th>Балансова вартість</th>
            <th>Оціночна вартість, грн.</th>
            <th>В заставі НБУ</th>
            <th>Дата аукціону</th>
            <th>Біржа</th>
        </tr>
    </table>

</div>
</body>
</html>