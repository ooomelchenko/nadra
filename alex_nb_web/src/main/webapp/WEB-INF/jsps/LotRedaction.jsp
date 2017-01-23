<%@ page import="nadrabank.domain.Bid" %>
<%@ page import="nadrabank.domain.Exchange" %>
<%@ page import="nadrabank.domain.Lot" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.TreeSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setCharacterEncoding("UTF-8");%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
    Lot lot = (Lot) request.getAttribute("lott");
    List<String> bidStatusList = (List<String>) request.getAttribute("bidStatusList");
    List<String> statusList = (List<String>) request.getAttribute("statusList");
    List<String> bidResultList = (List<String>) request.getAttribute("bidResultList");
    List<Bid> allBidsList = (List<Bid>) request.getAttribute("allBidsList");
    Set<Bid> bidsHistoryList = (TreeSet<Bid>) request.getAttribute("bidsHistoryList");
    String userName = (String) request.getAttribute("user");
    List<String> fondDecisionsList = (List<String>) request.getAttribute("fondDecisionsList");
    List<Exchange> allExchangeList = (List<Exchange>) request.getAttribute("allExchangeList");
%>
<html>
<head>
    <title>Редагування лоту співробітником <%out.print(userName);%></title>
    <script src="js/jquery-1.11.1.js"></script>
    <link rel="stylesheet" media="screen" type="text/css" href="css/lotRedactionStyle.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="css/jquery-ui.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="css/jquery-ui.structure.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="css/jquery-ui.theme.css"/>
    <script type="text/javascript" src="js/jquery-ui.js"></script>
    <script type="text/javascript" src="js/docUploads.js"></script>
    <script>
        $(document).ready(function () {
            var payTab = $('#paysTab');
            var dp = $('.datepicker');
            var lotID = $('#lotId');
            var addPayButt = $('#addPay');
            dp.datepicker({
                dateFormat: "yy-mm-dd", dayNamesMin: ["Нд", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
                monthNames: ["січень", "лютий", "березень", "квітень", "травень", "червень", "липень", "серпень", "вересень", "жовтень", "листопад", "грудень"]
            });
            $('#inputFondDecDate').datepicker({
                dateFormat: "yy-mm-dd", dayNamesMin: ["Нд", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
                monthNames: ["січень", "лютий", "березень", "квітень", "травень", "червень", "липень", "серпень", "вересень", "жовтень", "листопад", "грудень"]
            });
            function getCountSum() {
                $('.payLine').remove();
                $.ajax({
                    url: "countSumByLot",
                    method: "POST",
                    data: {lotId: lotID.text()},
                    success: function (countSum) {
                        $('#count').text(countSum[0]);
                        $('#sum').text(countSum[1]);
                    }
                });
                $.ajax({
                    url: "paymentsSumByLot",
                    method: "POST",
                    data: {lotId: lotID.text()},
                    success: function (paymentsSum) {
                        $('#paymentsSum').text(paymentsSum);

                        var residualToPay = parseFloat($('#factPrice').val()) - parseFloat(paymentsSum);

                        if (isNaN(Number(residualToPay))) {
                            $('#residualToPay').text($('#factPrice').val());
                        }
                        else {
                            $('#residualToPay').text(Number(residualToPay).toFixed(2));
                        }
                    }
                });
                $.ajax({
                    url: "paymentsByLot",
                    method: "POST",
                    data: {lotId: lotID.text()},
                    success: function (payments) {

                        for (var i = 0; i < payments.length; i++) {
                            var d = new Date(payments[i].date);
                            d.setDate(d.getDate() + 1);
                            payTab.append($('<tr class="payLine" style="border: solid black">' +
                                '<td class="payId" hidden="hidden">' + payments[i].id + '</td>' +
                                '<td>' + d.toISOString().substring(0, 10) + '</td>' +
                                '<td>' + payments[i].paySum + '</td>' +
                                '<td>' + payments[i].paySource + '</td>' +
                                '<td><img class="delPayButt" src="images/delete.png" title="натисніть для видалення платежу"/></td>' +
                                '</tr>'));
                        }
                        $('.delPayButt').click(function () {
                            $.ajax({
                                url: "delPay",
                                method: "GET",
                                data: {payId: $(this).parent().parent().find('.payId').text()},
                                success: function (res) {
                                    if (res == "1") {
                                        alert("Платіж видалено!");
                                        getCountSum();
                                    }
                                    else
                                        alert("При видаленні проплати виникла проблема!!! Зверніться до адміністратора!");
                                }
                            });
                        })
                    }
                });
            }

            getFileNames(lotID.text(), $("#objType").val());
            getCountSum();

            $('.reBidButton').click(function () {
                $.ajax({
                    url: "reBidByLot",
                    type: "GET",
                    data: {
                        lotId: lotID.text(),
                        reqType: $(this).val()
                    },
                    success: function (res) {
                        if (res == 1)
                            location.reload(true);
                        else alert("Якась халепа!");
                    }
                })
            });
            $('#delLotButton').click(function () {
                if ($(this).val() === '1') {
                    $('#delImg').hide();
                    $(this).val('0');
                    //$('#lotTh').css('backgroundColor', "sandybrown");
                    $('#count').css('backgroundColor', "#f0ffff");
                    $('#sum').css('backgroundColor', "#f0ffff");
                }
                else {
                    $('#setSoldButton').val('0');
                    $('#soldImg').hide();
                    $('#delImg').show();
                    $(this).val('1');
                    //  $('#lotTh').css('backgroundColor', "#dc143c");
                    $('#count').css('backgroundColor', "#dc143c");
                    $('#sum').css('backgroundColor', "#dc143c");
                    alert('Увага! Лот буде розформовано після підтвердження!')
                }
            });
            $('#setSoldButton').click(function () {
                if ($(this).val() === '1') {
                    $('#soldImg').hide();
                    $(this).val('0');
                    // $('#lotTh').css('backgroundColor', "sandybrown");
                    $('#count').css('backgroundColor', "#f0ffff");
                    $('#sum').css('backgroundColor', "#f0ffff");
                }
                else {
                    if ($('#ws').val() != "Угода укладена") {
                        alert("Змініть стадію на 'Угода укладена!'");
                    }
                    else if ($('#factPrice').val() == '') {
                        alert('Введіть ціну фактичного продажу!');
                    }
                    else {
                        $('#delImg').hide();
                        $('#soldImg').show();
                        $('#delLotButton').val('0');
                        $(this).val('1');
                        //   $('#lotTh').css('backgroundColor', "lawngreen");
                        $('#count').css('backgroundColor', "lawngreen");
                        $('#sum').css('backgroundColor', "lawngreen");
                        alert('Статус буде збереження після підтвердження!')
                    }
                }
            });
            $('#showCredits').click(function showCredits() {
                var tab;
                <%if (lot.getLotType()==1){%>
                tab = $('#assetsTab');
                <% }
                if (lot.getLotType()==0){
                %>
                tab = $('#crdtsTab');
                <% } %>
                if (tab.is(':visible')) {
                    tab.hide();
                }
                else {
                    $('.tR').remove();
                    tab.show();
                    <%if (lot.getLotType()==1){%>
                    $.ajax({
                        url: "selectAssetsbyLot",
                        type: "POST",
                        data: {
                            lotId: $('#lotId').text()
                        },
                        success: function (objList) {
                            for (var i = 0; i < objList.length; i++) {
                                var approveNBU = objList[i].approveNBU ? "Так" : "Ні";
                                var neadNewFondDec = objList[i].neadNewFondDec ? "Так" : "Ні";
                                var trR = $('<tr align="center" class="tR">' +
                                    '<td class="idLot" hidden="hidden">' + objList[i].id + '</td>' +
                                    '<td>' + objList[i].inn + '</td>' +
                                    '<td>' + objList[i].asset_name + '</td>' +
                                    '<td>' + objList[i].asset_descr + '</td>' +
                                    '<td>' + objList[i].region + '</td>' +
                                    '<td>' + objList[i].zb + '</td>' +
                                    '<td>' + objList[i].rv + '</td>' +
                                    '<td>' + objList[i].acceptPrice + '</td>' +
                                    '<td>' + objList[i].factPrice + '</td>' +
                                    '<td>' + neadNewFondDec + '</td>' +
                                    '<td>' + approveNBU + '</td>' +
                                    '</tr>');
                                //var factPriceTd = trR.find('.factPriceTd');

                                if (objList[i].sold) {
                                    trR.css('background-color', "lightgreen");
                                }
                                else {
                                    var delCrButt = $('<button class="delCrdButt" value="0" title="Видалити обєкт">' +
                                        '<img height="22px" width="22px" src="css/images/red-del.png">' +
                                        '</button>').click(function () {
                                        if ($(this).val() === '0') {
                                            $(this).val('1');
                                            $(this).parent().css('background-color', "lightcoral");
                                            $(this).parent().attr('title', "Об'єкт буде видалено зі списку!")
                                        }
                                        else {
                                            $(this).val('0');
                                            $(this).parent().css('background-color', 'lightcyan');
                                            $(this).parent().attr('title', "")
                                        }
                                    });
                                    trR.append(delCrButt);
                                }
                                tab.append(trR);
                            }
                        }
                    });
                    <% } %>
                    <%if (lot.getLotType()==0){%>
                    $.ajax({
                        url: "selectCreditsLot",
                        type: "POST",
                        data: {
                            lotId: $('#lotId').text()
                        },
                        success: function (objList) {
                            for (var i = 0; i < objList.length; i++) {
                                var approveNBU = objList[i].nbuPladge ? "Так" : "Ні";
                                var neadNewFondDec = objList[i].neadNewFondDec ? "Так" : "Ні";
                                var trR = $('<tr align="center" class="tR">' +
                                    '<td class="idLot">' + objList[i].id + '</td>' +
                                    '<td>' + objList[i].inn + '</td>' +
                                    '<td>' + objList[i].fio + '</td>' +
                                    '<td>' + objList[i].product + '</td>' +
                                    '<td>' + objList[i].region + '</td>' +
                                    '<td>' + objList[i].zb + '</td>' +
                                    '<td>' + objList[i].rv + '</td>' +
                                    '<td>' + objList[i].acceptPrice + '</td>' +
                                    '<td>' + objList[i].factPrice + '</td>' +
                                    '<td>' + neadNewFondDec + '</td>' +
                                    '<td>' + approveNBU + '</td>' +
                                    '</tr>');
                                //var factPriceTd = trR.find('.factPriceTd');

                                if (objList[i].isSold) {
                                    trR.css('background-color', "lightgreen");
                                }
                                else {
                                    var delCrButt = $('<button class="delCrdButt" value="0" title="Видалити обєкт">' +
                                        '<img height="22px" width="22px" src="css/images/red-del.png">' +
                                        '</button>').click(function () {
                                        if ($(this).val() === '0') {
                                            $(this).val('1');
                                            $(this).parent().css('background-color', "lightcoral");
                                            $(this).parent().attr('title', "Об'єкт буде видалено зі списку!")
                                        }
                                        else {
                                            $(this).val('0');
                                            $(this).parent().css('background-color', 'lightcyan');
                                            $(this).parent().attr('title', "")
                                        }
                                    });
                                    trR.append(delCrButt);
                                }
                                tab.append(trR);
                            }
                        }
                    });
                    <% } %>
                    $('#objBlock').append(tab);
                }

            });
            $('#bidTd').dblclick(function () {
                if ($(this).val() == 0) {
                    $('#bidName').hide();
                    $('#bidSelector').show();
                    $(this).val(1);
                }
                else {
                    $('#bidName').show();
                    $('#bidSelector').hide();
                    $(this).val(0);
                }
            });
            $('#butAccept').click(function () {
                if ($('#delLotButton').val() === '0') {

                    $('.delCrdButt').each(function () {
                        if ($(this).val() === '1') {
                            var idL = $(this).parent().children().first().text();
                            $.ajax({
                                url: "delObjectFromLot",
                                type: 'POST',
                                data: {
                                    objId: idL,
                                    lotId: $('#lotId').text()
                                },
                                success(res){
                                    if (res == "0")
                                        alert("Об'єкт не видалено!");
                                }
                            })
                        }
                    });

                    $.ajax({
                        url: "changeLotParams",
                        method: "POST",
                        data: {
                            lotId: $('#lotId').text(),
                            workStage: $('#ws').val(),
                            comment: $('#comm').val(),
                            bidStage: $('#bidst').val(),
                            lotNum: $('#lotNum').val(),
                            resultStatus: $('#bidResultSt').val(),
                            customer: $('#customerName').val(),
                            firstPrice: $('#firstPrice').val(),
                            startPrice: $('#startPrice').val(),
                            factPrice: $('#factPrice').val(),
                            isSold: $('#setSoldButton').val(),
                            selectedBidId: $('#bidSelector').val(),
                            countOfParticipants: $('#countOfPart').val()
                        },
                        success: function (rez) {
                            if (rez === "1") {
                                alert("Лот змінено!");
                                location.reload(true);
                            }
                            else alert("Лот не змінено!")
                        }
                    });
                }
                else {
                    $.ajax({
                        url: "lotDel",
                        method: "POST",
                        data: {lotID: $('#lotId').text()},
                        success(rez){
                            if (rez === "1") {
                                alert("Лот видалено!");
                                window.close()
                            }
                            else alert("Лот не видалено!")
                        }
                    });
                }
            });
            $('#showAddDoc').click(function () {
                var addDocForm = $("#addDocForm");
                if (addDocForm.is(':visible')) {
                    $(this).text("+Додати+");
                    addDocForm.hide();
                }
                else {
                    $(this).text("Приховати");
                    addDocForm.show();
                }
            });
            $('#doc1').click(function () {
                $.ajax({
                    url: "setLotToPrint",
                    type: "GET",
                    data: {objId: $('#lotId').text()},
                    success: function (res) {
                        if (res == '1') {
                            window.open("download");
                        }
                    }
                });
            });
            /*$('#paymentsSum').click(function () {
                if (payTab.is(':hidden')) {
                    payTab.show();
                }
                else payTab.hide();
            });*/
            addPayButt.click(function adder() {
                var payTd = $('.payTd');
                var payDate = $('#payDate');
                var pay = $('#pay');
                var paySource = $('#paySource');
                if ($(this).val() == '1') {
                    if (isNaN(parseFloat(pay.val()))) {
                        alert("Введіть будь-ласка суму платежу у коректному форматі!")
                    }
                    else {
                        $.ajax({
                            url: "addPayToLot",
                            method: "POST",
                            data: {
                                lotId: $('#lotId').text(),
                                payDate: payDate.val(),
                                pay: pay.val(),
                                paySource: paySource.val()
                            },
                            success(rez){
                                if (rez === "1") {
                                    alert("Платіж додано!");
                                    getCountSum();
                                    payDate.val(null);
                                    pay.val(null);
                                    payTd.hide();
                                    addPayButt.val('0');
                                    addPayButt.text('Додати платіж');
                                    //adder();
                                }
                                else alert("Платіж НЕ ДОДАНО!")
                            }
                        });
                    }
                }
                else {
                    payTd.show();
                    addPayButt.val('1');
                    addPayButt.text('OK');
                }
            });
            $("#bidDate").click(function () {
                var bidHistoryTr = $(".bidHistoryTr");
                if (bidHistoryTr.is(":hidden"))
                    bidHistoryTr.show();
                else
                    bidHistoryTr.hide();
            });

            var redactButton = $('#redactButton');
            redactButton.click(function () {
                if (redactButton.val() === "0") {
                    redactButton.val(1);
                    redactButton.text("Прийняти");
                    $('#fdChoose').show();
                    $('#fdCurrent').hide();
                }
                else {
                    redactButton.val(0);
                    redactButton.text("Додати рішення");
                    $.ajax({
                        url: "changeFondDec",
                        type: "POST",
                        data: {
                            lotId: <%out.print(lot.getId());%>,
                            fondDecDate: $('#inputFondDecDate').val(),
                            fondDec: $('#inputFondDec').val(),
                            decNum: $('#inputFondDecNum').val()
                        },
                        success: function (res) {
                            if (res == 1) {
                                alert("Зміни прийнято!");
                                location.reload(true);
                            }
                        }
                    });
                }
            });

            $("#okButton").click(function () {
                $.ajax({
                    url: "setAcceptEx",
                    type: "POST",
                    data: {
                        lotId: $('#lotId').text(),
                        acceptEx: $('#inputAccEx').val()
                    },
                    success: function (result) {
                        if (result == "1") {
                            alert("затверджена біржа змінена!");
                            location.reload(true);
                        }
                        else alert("данні не внесені!");
                    }
                });
            });
            $('.acceptEx').dblclick(function () {
                var accExChoose = $("#accExChoose");
                var accExCurrent = $('#accExCurrent');
                var okButton = $("#okButton");
                if (accExChoose.is(":hidden")) {
                    accExChoose.show();
                    accExCurrent.hide();
                }
                else {
                    accExChoose.hide();
                    accExCurrent.show();
                }
            });
            $('#firstPriceTd').dblclick(function(){
                $(this).find('div').remove();
                $(this).find('input').show();
            });

            <%if (lot.getItSold()){%>
            $('#delLotButton').hide();
            $('#setSoldButton').hide();
            $('#firstPrice').hide();
            $('#firstPriceTd').append(<%=lot.getFirstStartPrice()%>);
            $('#factPrice').hide();
            $('#factPriceTd').append(<%out.print(lot.getFactPrice());%>);
            <%}%>
        })
    </script>
</head>
<body>

<div id="b0">
    <table id="lotAboutTab">
        <tr class="lotAbout">
            <td>ID лоту</td>
            <td id="lotId"><%out.print(lot.getId());%></td>
        </tr>
    </table>
</div>

<div id="b1">
    <div id="bidBlock">
        <table id="bidTab">
            <tr align="center">
                <th>Біржа</th>
                <td id="bidTd" title="клікніть двічі для зміни торгів">
                    <p id="bidName">
                        <%
                            if (lot.getBid() != null && lot.getBid().getExchange() != null)
                                out.print(lot.getBid().getExchange().getCompanyName());
                        %>
                    </p>
                    <select id="bidSelector" hidden="hidden">
                        <option value="0">
                        </option>
                        <% for (Bid bid : allBidsList) { %>
                        <option value="<%out.print(bid.getId());%>"<%if (lot.getBid() != null && lot.getBid().getId().equals(bid.getId())) {%>
                                selected="selected"<%
                                ;
                            }
                        %>>
                            <%
                                out.print(sdf.format(bid.getBidDate()) + " - " + bid.getExchange().getCompanyName());
                            %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Стадія</th>
                <td>
                    <select id="ws">
                        <% for (String ws : statusList) {%>
                        <option value="<%out.print(ws);%>" <%if (ws.equals(lot.getWorkStage())) {%>
                                selected="selected" <%
                                ;
                            }
                        %>>
                            <%
                                out.print(ws);
                            %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Торги</th>
                <td>
                    <select id="bidst">
                        <% for (String bidst : bidStatusList) {
                        %>
                        <option value="<%out.print(bidst);%>" <%if (bidst.equals(lot.getBidStage())) {%>
                                selected="selected" <%
                                ;
                            }
                        %>>
                            <%
                                out.print(bidst);
                            %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Статус аукціону</th>
                <td>
                    <select id="bidResultSt">
                        <% for (String resultStatus : bidResultList) {
                        %>
                        <option value="<%out.print(resultStatus);%>" <%if (resultStatus.equals(lot.getStatus())) {%>
                                selected="selected" <%
                                ;
                            }
                        %>>
                            <%
                                out.print(resultStatus);
                            %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Кінець реєстрації</th>
                <td>
                    <%
                        if (lot.getBid() != null && lot.getBid().getRegistrEndDate() != null)
                            out.print(sdf.format(lot.getBid().getRegistrEndDate()));
                    %>
                </td>
            </tr>
            <tr>
                <th>Дата торгів</th>
                <td id="bidDate" title="натисніть для перегляду історії">
                    <%
                        if (lot.getBid() != null && lot.getBid().getBidDate() != null)
                            out.print(sdf.format(lot.getBid().getBidDate()));
                    %>
                </td>
            </tr>

            <%for (Bid bid : bidsHistoryList) {%>
            <tr class="bidHistoryTr" hidden="hidden" title="Історія попередніх торгів">
                <td align="left">
                    <%out.print(bid.getExchange().getCompanyName());%>
                </td>
                <td>
                    <%if (bid.getBidDate() != null) out.print(sdf.format(bid.getBidDate()));%>
                </td>
            </tr>
            <%}%>

            <tr>
                <td title="Повторні торги на біржі">
                    <button style="width: 100%" class="reBidButton" value="1">Повторні торги</button>
                </td>
            </tr>
        </table>
    </div>
    <div id="fdBlock">
        <h2>Погодження продажу ФГВФО</h2>
        <table id="fdTab">
            <tr id="accExCurrent" title="клікніть двічі для зміни погодженої фондом біржі">
                <td colspan="3" class="acceptEx">
                    <%out.print(lot.getAcceptExchange());%>
                </td>
            </tr>
            <tr id="accExChoose" hidden="hidden">
                <td colspan="2">
                    <select id="inputAccEx" name="exSelect">
                        <%
                            if (allExchangeList != null) {
                                for (Exchange ex : allExchangeList) {
                        %>
                        <option value="<%=ex.getId()%>">
                            <%out.print(ex.getCompanyName());%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
                <td>
                    <button id='okButton' style="width: 100%">ok</button>
                </td>
            </tr>
            <tr id="fdCurrent">
                <td><%if (lot.getFondDecisionDate() != null) out.print(sdf.format(lot.getFondDecisionDate()));%></td>
                <td><%if (lot.getFondDecision() != null) out.print(lot.getFondDecision());%></td>
                <td><%if (lot.getDecisionNumber() != null) out.print(lot.getDecisionNumber());%></td>
            </tr>
            <tr id="fdChoose" hidden="hidden">
                <td>
                    <input id="inputFondDecDate" title="Дата прийняття рішення" placeholder="дата рішення">
                </td>
                <td>
                    <select id="inputFondDec" name="decisionSelect" title="Рівень прийняття рішення">
                        <%
                            if (fondDecisionsList != null) {
                                for (String decision : fondDecisionsList) {
                        %>
                        <option value="<%=decision%>">
                            <%out.print(decision);%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
                <td>
                    <input id="inputFondDecNum" type="text" title="Номер рішення" placeholder="номер рішення">
                </td>
            </tr>
            <tr>
                <td title="Необхідне перепогодження ФГВФО">
                    <button class="reBidButton" value="2" style="width: 100%; color: darkred" title="Необхідне перепогодження ФГВФО">
                        Необхідне перепогодження
                    </button>
                </td>
                <td style="background-color: transparent"></td>
                <td>
                    <button id="redactButton" value="0" style="width: 100%; color: darkblue" title="Додати актуальне рішення ФГВФО">
                        Додати рішення
                    </button>
                </td>
            </tr>
        </table>
    </div>
    <div id="payBlock">
        <h2>Платежі по лоту</h2>
        <table id="paysTab" ><%--заповнюється скриптом--%>
        </table>
        <table width="100%">
            <tr>
                <th class="payTd" hidden="hidden">
                    <input id="payDate" class="datepicker" placeholder="дата платежу" title="введіть дату платежу">
                </th>
                <th class="payTd" hidden="hidden">
                    <input id="pay" type="number" step="0.01" placeholder="сума, грн" title="введіть суму платежу">
                </th>
                <th class="payTd" hidden="hidden">
                    <select id="paySource" style="width: 100px" title="оберіть джерело надходження коштів">
                        <option value="Біржа">
                            Біржа
                        </option>
                        <option value="Покупець">
                            Покупець
                        </option>
                    </select>
                </th>
            </tr>
            <tr>
                <th colspan="3">
                    <button id="addPay" style="width:100%">Додати платіж</button>
                </th>
            </tr>
        </table>
    </div>
    <div id="docBlock">
        <table id="fileList" border="1">
            <tr>
                <th>
                    Документи по Лоту
                </th>
            </tr>
        </table>
        <table>
            <tr style="text-align: right">
                <td>
                    <button id="showAddDoc">+Додати+</button>
                </td>
            </tr>
            <tr id="addDocForm" hidden="hidden" bgcolor="#f5f5dc">
                <td>
                    <form method="POST" action="uploadFile" enctype="multipart/form-data" lang="utf8">
                        <input type="text" id="objType" name="objType" value="lot" hidden="hidden">
                        <input type="text" name="objId" value="<%out.print(lot.getId());%>" hidden="hidden">
                        Обрати документ для збереження:
                        <br/>
                        <input align="center" type="file" name="file" title="натисніть для обрання файлу"><br/>
                        <input align="center" type="submit" value="Зберегти" title="натисніть щоб зберегти файл">
                    </form>
                </td>
            </tr>
        </table>
    </div>
</div>

<div id="b2">
    <div id="bar">
        <div id="financeBlock">
            <table id="controlTab" border="1">
                <tr>
                    <th bgcolor="#00ffff">К-ть об'єктів</th>
                    <td id="count" align="center" bgcolor="#f0ffff"></td>
                    <th bgcolor="#00ffff">№ лоту в публікації</th>
                    <th bgcolor="#00ffff">К-ть учасників</th>
                    <th bgcolor="#00ffff">Покупець</th>
                    <th bgcolor="#00ffff">Початкова ціна</th>
                    <th bgcolor="#00ffff">Дисконт</th>
                    <th bgcolor="#00ffff">Стартова ціна аукціону</th>
                    <th bgcolor="#00ffff">Ціна продажу, грн.</th>
                    <th bgcolor="#00ffff">Залишок до сплати, грн.</th>
                    <th bgcolor="#00ffff">Фактично сплачено, грн.</th>
                    <td rowspan="2" id="soldImg" hidden="hidden">
                        <img height="50px" width="50px" src="css/images/green-round-tick-sign.jpg">
                    </td>
                    <td rowspan="2" id="delImg" hidden="hidden">
                        <img height="50px" width="50px" src="css/images/red-del.png">
                    </td>
                </tr>
                <tr id="finInfoTr">
                    <th bgcolor="#00ffff">Оціночна вартість, грн</th>
                    <td id="sum" align="center" bgcolor="#f0ffff"></td>
                    <td><input id="lotNum" type="text" value="<%if(lot.getLotNum()!=null)out.print(lot.getLotNum());%>">
                    </td>
                    <td><input id="countOfPart" type="number" value="<%out.print(lot.getCountOfParticipants());%>"></td>
                    <td><input id="customerName" type="text" placeholder="ФІО"
                               value='<%if(lot.getCustomerName()!=null)out.print(lot.getCustomerName());%>'>
                    </td>
                    <td id="firstPriceTd" align="center">
                        <div><%=lot.getFirstStartPrice()%></div>
                        <input id="firstPrice" type="number" hidden="hidden" step="0.01" title="Початкова ціна лоту без дисконту"
                               value="<%out.print(lot.getFirstStartPrice());%>">
                    </td>
                    <td id="discount" align="center" title="Дисконт відносно початкової ціни на перших торгах">
                        <%
                            if (lot.getStartPrice() != null && lot.getFirstStartPrice() != null)
                                out.print((new BigDecimal(1).subtract(lot.getStartPrice().divide(lot.getFirstStartPrice(), 4, BigDecimal.ROUND_HALF_UP))).multiply(new BigDecimal(100)).setScale(2, BigDecimal.ROUND_HALF_UP) + "%");
                        %>
                    </td>
                    <td id="startPriceTd" align="center">
                        <input id="startPrice" type="number" step="0.01" title="Ціна лоту на актуальному аукціоні"
                               value="<%out.print(lot.getStartPrice());%>">
                    </td>
                    <td id="factPriceTd" align="center">
                        <input id="factPrice" type="number" step="0.01" title="Ціна за яку фактично продано лот"
                               value=<%out.print(lot.getFactPrice());%>>
                    </td>
                    <td id="residualToPay" align="center" title="Залишок до сплати (ціна продажу-сплчено)">
                    </td>
                    <td id="paymentsSum" datatype="number" align="center"
                        title="Клікніть для розгорнутого перегляду платежів">
                    </td>

                </tr>
            </table>
        </div>
        <br/>
        <div id="commBlock">
            <table style="width: 100%">
                <tr>
                    <td>
                        <input id="comm" value="<%if(lot.getComment()!=null)out.print(lot.getComment());%>"
                               placeholder="Коментар" title="Введіть коментарі стосовно особливостей лоту">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="mainButBlock">
        <div id="butBlock">
            <div>
                <%--<img id="delLotButton" value="0" src="images/del.png"/>--%>
                <button id="delLotButton" value="0">Видалити лот</button>
            </div>
            <div>
                <button id="setSoldButton" value="0">Акт підписано</button>
            </div>
        </div>
        <br/>
        <div id="acceptButBlock">
            <button id="butAccept" title="натисніть для збереження змін">
                ПІДТВЕРДИТИ
            </button>
        </div>
    </div>
</div>

<div id="objBlock" class="view" align="center">
    <table align="center">
        <tr>
            <td align="center">
                <button id="showCredits" title="Показати/Приховати список об'єктів в лоті">Список об'єктів</button>
            </td>
            <td align="right" title="натисніть для збереження в форматі .xls">
                <img id="doc1" src="images/excel.jpg" width="30px" height="30px"/>
            </td>
        </tr>
    </table>
    <table id="assetsTab" border="light" class="table" hidden="hidden">
        <tr bgcolor="limegreen">
            <th hidden="hidden">ID</th>
            <th>Інвентарний №</th>
            <th>Назва активу</th>
            <th>Опис обєкту</th>
            <th>Регіон</th>
            <th>Балансова вартість</th>
            <th>Оціночна вартість, грн.</th>
            <th>Затверджена ФГВФО ціна, грн.</th>
            <th>Ціна продажу, грн.</th>
            <th>Необхідно перепогодити</th>
            <th>В заставі НБУ</th>
        </tr>
    </table>
    <table id="crdtsTab" border="light" class="table" hidden="hidden">
        <tr bgcolor="#00bfff">
            <th>ID_Bars</th>
            <th>ІНН</th>
            <th>Назва</th>
            <th>Опис обєкту</th>
            <th>Регіон</th>
            <th>Балансова вартість</th>
            <th>Оціночна вартість, грн.</th>
            <th>Затверджена ФГВФО ціна, грн.</th>
            <th>Ціна продажу, грн.</th>
            <th>Необхідно перепогодити</th>
            <th>В заставі НБУ</th>
        </tr>
    </table>
</div>

</body>
</html>