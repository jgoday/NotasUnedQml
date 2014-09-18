.pragma library

var credentials = {
    username: null,
    password: null
};

var selectedMonth = null;

function monthToText() {
    switch (selectedMonth) {
        case 0 : return "Febrero";
        case 1: return "Junio";
        case 2: return "Septiembre";
        default: return "";
    }
}

function credentialsAndMonth() {
    if (selectedMonth != null)
        return "Convocatoria: <b>" +
                monthToText() + "</b> " +
                "Usuario: <b>" + credentials.username + "</b>"
    else
        return "Usuario: <b>" + credentials.username + "</b>"
}
