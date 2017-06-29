$(document).ready(function () {
    var ftab = $('.findTab');
    var ltab = $('.lotTab');

    calculate();

    function addToFindTab(obj) {
        ltab.hide();
        $('.findTab').find('.ftr').remove();
        ftab.show();

        for (var i = 0; i < obj.length; i++) {
            var approveNBU = obj[i].nbuPladge ? "Так" : "Ні";
            var tr = $('<tr class="ftr" align="center">' +
                '<td class="idObj" hidden="hidden">' + obj[i].id + '</td>' +
                '<td class="ndObj">' + obj[i].nd + '</td>' +
                '<td>' + obj[i].inn + '</td>' +
                '<td>' + obj[i].fio + '</td>' +
                '<td>' + obj[i].product + '</td>' +
                '<td>' + obj[i].region + '</td>' +
                '<td>' + obj[i].zb + '</td>' +
                '<td>' + obj[i].rv + '</td>' +
                '<td>' + approveNBU + '</td>' +
                '</tr>');

            var addButton = $('<button class="addButton">Додати в лот</button>');
            addButton.click(function () {
                var thisTr = $(this).parent();
                ltab.append(thisTr);
                $(this).remove();

                var delButton = $('<button id="delButton">Видалити</button>');
                thisTr.append(delButton);
                delButton.click(function () {
                    $(this).parent().remove();
                    calculate();
                });
                calculate();
            });
            var messageTd = $('<td bgcolor="#00ffff">Вже додано до лоту</td>');

            ftab.append(tr);
            tr.append(addButton);

            var idF = tr.children().first().text();
            var lids = ltab.find('.idObj');
            for (var j = 0; j < lids.length; j++) {
                if (lids[j].innerHTML == idF) {
                    addButton.remove();
                    tr.append(messageTd);
                }
            }
        }
    }

    $('#findObjBut').click( function () {
        ltab.hide();
        $('.findTab').find('.ftr').remove();
        ftab.show();

        $.ajax({
            url: "creditsByClient",
            method: "POST",
            data: {
                inn: $('#inn').val(),
                idBars: $('#idBars').val()
            },
            success(obj){
                addToFindTab(obj);
            }
        });
    });
    $('#showLCrdts').click( function () {
        ftab.hide();
        ltab.show();
    });

    function calculate() {
        var tdId = ltab.find('.idObj');

        var idl = "";
        for (var i = 0; i < tdId.length; i++) {
            idl = idl + ',' + tdId[i].innerHTML;
        }
        $.ajax({
            url: "sumByIDBars",
            method: "POST",
            data: {idMass: idl},
            success(summ){
                if (summ)
                    $('#priceId').text(summ);
                $('#kolId').text(tdId.length);
            }
        });
    }

    $('#createLot').click(function createLot() {
        var tdId = ltab.find('.idObj');
        var idl = "";
        for (var i = 0; i < tdId.length; i++) {
            idl = idl + ',' + tdId[i].innerHTML;
        }
        $.ajax({
            url: "createCreditLot",
            method: "POST",
            data: {
                idMass: idl,
                comment: $('#commIn').val()
            },
            success(ok){
                if (ok == '1') {
                    alert("Лот створено!");
                    location.href = "lotRedactor";
                }
                else
                    alert("Лот не створено!");
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

    $('.addAllBut').click(function () {
        ftab.find('.ftr').each(function () {
                var ftr = $('.ftr');
                ltab.append(ftr);
            }
        );
        $('.addButton').remove();
        calculate();
    });

});