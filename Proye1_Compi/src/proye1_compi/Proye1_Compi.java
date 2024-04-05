
package proye1_compi;

import jflex.exceptions.SilentExit;

/**
 *
 * @author fredd
 */
public class Proye1_Compi {

    public static void main(String[] args) throws SilentExit {
        // TODO code application logic here
        String path = "C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\lexer.flex";
        generarLexer(path);
    }
    
    public static void generarLexer(String path) throws SilentExit {
        String[] strArr =  {path};
        jflex.Main.generate(strArr);
    }
    
}
