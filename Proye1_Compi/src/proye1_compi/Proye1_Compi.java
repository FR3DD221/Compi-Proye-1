
package proye1_compi;

import java.io.IOException;
import jflex.exceptions.SilentExit;

/**
 *
 * @author fredd
 */
public class Proye1_Compi {

    public static void main(String[] args) throws SilentExit, Exception {
        // TODO code application logic here
        String path = "C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\lexer.flex";
        String path2 = "C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\Sintax.cup";
        generarLexer(path);
        generarParser(path2);
    }
    
    public static void generarLexer(String path) throws SilentExit {
        String[] strArr =  {path};
        jflex.Main.generate(strArr);
    }
    
    public static void generarParser(String path) throws IOException, Exception {
        String[] strArr = { "-parser", "Parser", path };
        java_cup.Main.main(strArr);
    }
}
