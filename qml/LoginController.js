function validate(username, password) {
    if (username.text === "") {
        return { error : "Debes introducir el nombre de usuario" }
    }
    else if (password.text === "") {
        return { error : "Debes introducir la clave " }
    }

    return { ok: true };
}

function doLogin()
{
    var result = Controller.validate(username, password)
    error.text = ""

    if (result.ok === true) {
        credentialsEntered(username.text, password.text, rememberUser.checked)
    }
    else {
        error.text = result.error
    }
}
