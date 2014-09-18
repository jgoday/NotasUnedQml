var Const = {
    LoginUrl: "https://sso.uned.es/sso/index.aspx?URL=https://login.uned.es/ssouned/login.jsp",
    GradosUrl: "https://serviweb.uned.es/sec-virtual/calificaciones/grados.asp",
    MainPage: "http://portal.uned.es/portal/page?_pageid=93,153054&_dad=portal&_schema=PORTAL",
    ErrorPage: "https://sso.uned.es/sso/index.aspx?URL=https%3A%2F%2Flogin.uned.es%2Fssouned%2Flogin.jsp",
    UserName: "ContentPlaceHolder1_ssousername",
    Password: "ContentPlaceHolder1_password",
    SubmitButton: "ContentPlaceHolder1_enviar",
    LoginError: "ContentPlaceHolder1_lbl_error",
    ConvocatoriaRadio: "Convocatoria",
    ConvocatoriaFebrero: 0,
    ConvocatoriaJunio: 1,
    ConvocatoriaSeptiembre: 2,
    LoginForm: "loginform"
}

function DoWork(obj, month, name, pass) {
    var f = obj.experimental.evaluateJavaScript
    var url = obj.url.toString()

    if (Const.LoginUrl === url) {
        doLogin(obj, name, pass);
    }
    else if (Const.ErrorPage === url) {
        var err = Js.byId(Const.LoginError);
        var js = Js.postMessage(err.innerHTML(), true);

        f(js.toJs());
    }
    else if (Const.MainPage === url) {
        obj.url = Const.GradosUrl;
    }
    else if (Const.GradosUrl === url) {
        var js1 = Js.doIf(
                    Js.byId(Const.LoginForm).exists(),
                    Js.byName(Const.ConvocatoriaRadio, month).check(),
                    Js.byName("Enviar", 0).click());

        var center = Js.byTag("center", 0);
        var notas = Js.byClassName("notas", 0);

        var js2 = Js.doIfElse(
                    notas.exists(),
                    Js.postMessage(notas.innerHTML()),
                    Js.doIf(center.exists(), Js.postMessage(center.innerHTML())));

        f(js1.and(js2).toJs());
    }
}

function doLogin(obj, name, pass) {
    var f = obj.experimental.evaluateJavaScript

    f(Js.byId(Const.UserName).setValue(name).toJs());
    f(Js.byId(Const.Password).setValue(pass).toJs());

    f(Js.byId(Const.SubmitButton).click().toJs());
}


var Js = {
    eval: function(e) {
        if (e instanceof JsExpr) return e.toJs();
        else return "'" + e + "'";
    },
    byId: function(id) {
        return new JsExpr("document.getElementById('" + id + "')");
    },
    byClassName: function(className, index) {
        if (index === undefined)
            return new JsExpr("document.getElementsByClassName('" + className + "')");
        else
            return new JsExpr("document.getElementsByClassName('" + className + "')[" + index + "]");
    },
    byTag: function(tag, index) {
        if (index === undefined)
            return new JsExpr("document.getElementsByTagName('" + tag + "')");
        else
            return new JsExpr("document.getElementsByTagName('" + tag + "')[" + index + "]");
    },
    byName: function(name, index) {
        if (index === undefined)
            return new JsExpr("document.getElementsByName('" + name + "')");
        else
            return new JsExpr("document.getElementsByName('" + name + "')[" + index + "]");
    },
    alert: function(msg) {
        return new JsExpr("alert('" + msg + "');");
    },
    doIf: function(cond) {
        var c = this.eval(cond);
        var work = "";
        for (var i = 1; i < arguments.length; i++) {
            work = work + arguments[i].toJs() + ";";
        }

        return new JsExpr("if( " + c + " ) {" + work + " } ");
    },
    doIfElse: function(cond, a, b) {
        var c = this.eval(cond);

        return new JsExpr("if( " + c + " ) {" + this.eval(a) + " } else { " + this.eval(b) + "}");
    },
    postMessage: function(msg, isError) {
        if (isError) {
            var i = new JsExpr("var json = { }; \
                json.error = " + this.eval(msg) + "; \
                navigator.qt.postMessage(JSON.stringify(json));")
            return i;
        }
        else {
            var i = new JsExpr("var json = { }; \
                json.html = " + this.eval(msg) + "; \
                navigator.qt.postMessage(JSON.stringify(json));")
            return i;
        }
    }
}

function JsExpr(expr) {
    this.expr = expr;
}

JsExpr.prototype.toJs = function() {
    return this.expr;
};
JsExpr.prototype.click = function() {
    return new JsExpr(this.expr + ".click()");
};
JsExpr.prototype.submit = function() {
    return new JsExpr(this.expr + ".submit()");
};
JsExpr.prototype.and = function(e) {
    return new JsExpr(this.expr + ";" + e.toJs())
};
JsExpr.prototype.setValue = function(v) {
    return new JsExpr(this.expr + ".value = " + Js.eval(v));
};
JsExpr.prototype.check = function(v) {
    if (v === undefined) return new JsExpr(this.expr + ".checked = true;");
    else return new JsExpr(this.expr + ".checked = " + Js.eval(v) + ";");
}
JsExpr.prototype.exists = function() {
    return new JsExpr(this.expr + " != null ");
};
JsExpr.prototype.moreThan = function(v) {
    return new JsExpr(this.expr + ".length > " + v);
};
JsExpr.prototype.innerHTML = function() {
    return new JsExpr(this.expr + ".innerHTML");
}
