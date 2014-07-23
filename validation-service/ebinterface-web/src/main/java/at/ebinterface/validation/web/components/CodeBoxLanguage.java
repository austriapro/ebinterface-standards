package at.ebinterface.validation.web.components;


/**
 * Types of languages supported by the {@link CodeBox} component.
 * <p/>
 * In general it is not necessary to specify a language, however you can force
 * one by using one of these enumerated types.
 *
 * @author Richard Nichols
 * @version $Id: CodeBoxLanguage.java 256 2011-02-05 12:06:02Z tibes80@gmail.com
 *          $
 */
public enum CodeBoxLanguage {

    COMMON_LISP("lang-cl", "lang-lisp.js"), EMACS_LISP("lang-el", "lang-lisp.js"), LISP(
            "lang-lisp", "lang-lisp.js"), SCHEME("lang-scm", "lang-lisp.js"), CSS("lang-css",
            "lang-css.js"), HASKELL("lang-hs", "lang-hs.js"), LUA("lang-lua", "lang-lua.js"), PROTOCOL_BUFFERS(
            "lang-proto", "lang-proto.js"), SQL("lang-sql", "lang-sql.js"), VISUAL_BASIC("lang-vb",
            "lang-vb.js"), VB_SCRIPT("lang-vbs", "lang-vb.js"), GOOGLE_WIKI("lang-wiki",
            "lang-wiki.js"), // http://code.google.com/p/support/wiki/WikiSyntax
    APOLLO("lang-apollo", "lang-apollo.js"), // http://virtualagc.googlecode.com
    F_SHARP("lang-fs", "lang-ml.js"), ML("lang-ml", "lang-ml.js"), HTML("lang-html"), BASH(
            "lang-bsh"), C("lang-c"), CPP("lang-cpp"), CSHARP("lang-cs"), CYC("lang-cyc"), CV(
            "lang-cv"), JSON("lang-json"), JAVA("lang-java"), JAVASCRIPT("lang-js"), XML("lang-xml"), XSL(
            "lang-xsl"), PERL("lang-pl"), PYTHON("lang-py"), RUBY("lang-rb"), SHELL("lang-sh"), XHTML(
            "lang-xhtml");

    private final String cssClass;
    private final String extraJSfile;

    CodeBoxLanguage(String cssClass) {
        this.cssClass = cssClass;
        extraJSfile = null;
    }

    CodeBoxLanguage(String cssClass, String extraJSfile) {
        this.cssClass = cssClass;
        this.extraJSfile = extraJSfile;
    }

    public String getCSSClass() {
        return this.cssClass;
    }

    public String getExtraJSfile() {
        return extraJSfile;
    }

}
