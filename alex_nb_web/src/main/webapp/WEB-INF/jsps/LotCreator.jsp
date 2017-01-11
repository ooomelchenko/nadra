<%@ page import="nadrabank.domain.Asset" %>
<%@ page import="nadrabank.domain.Credit" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<% List<Asset> assetList = (List<Asset>) request.getAttribute("assetList"); %>
<% List<Credit> creditList = (List<Credit>) request.getAttribute("creditList"); %>
<% int lotType = (Integer) request.getAttribute("lotType"); %>
<head>
    <title>Створення лоту</title>
    <link rel="stylesheet" media="screen" type="text/css" href="css/lotCreatorStyle.css"/>
    <script src="js/jquery-1.11.1.js"></script>
    <%if(lotType==0){%> <script src="js/lotCrCreator.js"></script> <%}%>
    <%if(lotType==1){%> <script src="js/lotCreator.js"></script> <%}%>
</head>

<body style="background-color: mintcream">
<div>
    <button onclick="location.href='lotMenu'">Назад</button>
    <H1 align="center">Створення нового лоту</H1>
</div>

<div id="credSort" class="choice-box">

    <div>
        <table border="1" class="table" style="background-color: lightcyan; width: 100%" id="tblParam">
            <tr>
                <td colspan="2"><input id="commIn" type="text" style="width: 100%" placeholder="Коментар"></td>
            </tr>
            <tr>
                <th>Ціна лоту, грн.</th>
                <th>К-ть об'єктів</th>
            </tr>
            <tr>
                <td id="priceId" align="center">0</td>
                <td id="kolId" align="center">0</td>
            </tr>
            <tr>
                <td style="border: none" colspan="2">
                    <button id="showLCrdts" class="button"
                            style="background-color: cyan; width: 100%"> Показати список лоту
                    </button>
                </td>
            </tr>
        </table>
    </div>
    <div align="center">
        <button id="createLot" class="button" title="Натисніть для створення лоту з обраних об'єктів">
            СТВОРИТИ ЛОТ
        </button>
    </div>
    <div>
        <table style="width: 100%">
            <tr>
                <td>
                    <input id="inn" type="text" placeholder="Введіть ІНН для пошуку" style="width: 100%">
                </td>
            </tr>
            <%if(lotType==0){%>
            <tr>
                <td>
                    <input id="idBars" type="text" placeholder="Введіть ID_BARS" style="background-color: aliceblue; width: 100%">
                </td>
            </tr>
            <%}%>
            <tr>
                <td>
                    <button id="findObjBut" class="button" style="width: 100%">Знайти</button>
                </td>
            </tr>
        </table>
    </div>

</div>
<br/>
<%if (lotType == 0) {%>
<div class="view">
    <table class="findTab" border="2" hidden="hidden">
        <tr align="center" style="background-color: #003eff">
            <th>ID_BARS</th>
            <th>ІНН</th>
            <th>Боржник</th>
            <th>Опис кредиту</th>
            <th>Регіон</th>
            <th>Загальний борг</th>
            <th>Оціночна вартість, грн.</th>
            <th>В заставі НБУ</th>
        </tr>
    </table>
    <table class="lotTab" border="2" hidden="hidden" >
        <tr align="center" style="background-color: cyan">
            <th>ID_BARS</th>
            <th>ІНН</th>
            <th>Боржник</th>
            <th>Опис кредиту</th>
            <th>Регіон</th>
            <th>Загальний борг</th>
            <th>Оціночна вартість, грн.</th>
            <th>В заставі НБУ</th>
        </tr>
        <% for (Credit crdt : creditList) {
            if (crdt.getLot() == null /*&& !crdt.getFondDecision().equals("Відправлено до ФГВФО") && !crdt.getFondDecision().equals("")*/) {
        %>
        <tr align="center">
            <td class="idObj"><%=crdt.getId()%></td>
            <td><%=crdt.getInn()%></td>
            <td><%=crdt.getFio()%></td>
            <td><%=crdt.getProduct()%></td>
            <td><%=crdt.getRegion()%></td>
            <td><%=crdt.getZb()%></td>
            <td><%=crdt.getRv()%></td>
            <td><%if (crdt.getNbuPladge()) out.print("Так");else out.print("Ні");%></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>
<%}%>
<%if (lotType == 1) {%>
<div class="view">
    <table class="findTab" border="2" hidden="hidden">
        <tr align="center" style="background-color: #27d927">
            <th>ID</th>
            <th>Інвентарний №</th>
            <th>Назва активу</th>
            <th>Опис об'єкту</th>
            <th>Регіон</th>
            <th>Балансова вартість</th>
            <th>Оціночна вартість, грн.</th>
            <th>В заставі НБУ</th>
        </tr>
    </table>
    <table class="lotTab" border="2" hidden="hidden">
        <tr align="center" style="background-color: cyan">
            <th>ID</th>
            <th>Інвентарний №</th>
            <th>Назва активу</th>
            <th>Опис об'єкту</th>
            <th>Регіон</th>
            <th>Балансова вартість</th>
            <th>Оціночна вартість, грн.</th>
            <th>В заставі НБУ</th>
        </tr>

        <% for (Asset asset : assetList) {
            if (asset.getLot() == null /*&& !asset.getLot().getFondDecision().equals("Відправлено до ФГВФО") && !asset.getLot().getFondDecision().equals("")*/) {
        %>
        <tr align="center">
            <td class="idObj"><%=asset.getId()%></td>
            <td><%=asset.getInn()%></td>
            <td><%=asset.getAsset_name()%></td>
            <td><%=asset.getAsset_descr()%></td>
            <td><%=asset.getRegion()%></td>
            <td><%=asset.getZb()%></td>
            <td><%=asset.getRv()%></td>
            <td><%
                if (asset.isApproveNBU()) out.print("Так");
                else out.print("Ні");
            %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>
<%}%>
</body>
</html>