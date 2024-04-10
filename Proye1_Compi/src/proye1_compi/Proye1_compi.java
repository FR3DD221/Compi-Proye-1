
package proye1_compi;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java_cup.runtime.Symbol;
import jflex.exceptions.SilentExit;
import static jflex.logging.Out.println;

public class Proye1_compi {
    public static void main(String[] args) throws SilentExit, Exception {
        // TODO code application logic here
        String path = "C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\lexer.flex";
        String path2 = "C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\sintax.cup";
        //String path= "D:\\CompiladoresEInterpretes\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\lexer.flex";
        //String path2= "D:\\CompiladoresEInterpretes\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\sintax.cup";
        
        generarLexer(path);
        generarParser(path2);
        
        //move de los archivos  
        Path currentPath = Paths.get("");
        Path absolutePath = currentPath.toAbsolutePath();
        String currentDirectory = absolutePath.toString(); 

        String symLocation = currentDirectory + "\\sym.java";
        String ParserLocation = currentDirectory + "\\Parser.java";

        Path sym1 = Paths.get("").toAbsolutePath();
        String symd1 = sym1.toString();
        symd1 = symd1 + "\\src\\proye1_compi\\sym.java";

        Path par1 = Paths.get("").toAbsolutePath();
        String pard1 = par1.toString();
        pard1 = pard1 + "\\src\\proye1_compi\\Parser.java";

        generarLexer(path);
        generarParser(path2);
        
        Files.move(Paths.get(symLocation), Paths.get(symd1), StandardCopyOption.REPLACE_EXISTING);
        Files.move(Paths.get(ParserLocation), Paths.get(pard1), StandardCopyOption.REPLACE_EXISTING);
        
        test1("C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\test.txt");
        test2("C:\\Users\\fredd\\OneDrive\\Documentos\\GitHub\\Compi-Proye-1\\Proye1_Compi\\src\\proye1_compi\\test.txt");
    }
    
    public static void generarLexer(String path) throws SilentExit, IOException {
        try{
            String[] strArr =  {path};
            jflex.Main.generate(strArr);
        } catch(SilentExit e){
            System.err.println("Error al generar el lexer: " + e.getMessage());
        }
    }
    
    public static void generarParser(String path) throws IOException, Exception {
        try{
            String[] strArr = { "-parser", "Parser", path };
            java_cup.Main.main(strArr);
        } catch (Exception e){
            System.err.println("Error inesperado durante la generacion del parser " + e.getMessage());
        }
    }
    
    public static void test1(String ruta) throws FileNotFoundException, IOException, Exception {
        try (Reader reader = new BufferedReader(new FileReader(ruta))) {
            Lexer lex = new Lexer(reader);
            int i = 0;
            Symbol token;
            while (true) {
                token = lex.next_token();
                if (token.sym != 0) {
                    System.out.println("Token: " + token.sym + " " + (token.value == null ? lex.yytext() : token.value.toString()));
                } else {
                    System.out.println("Cantidad de lexemas encontrados: " + i);
                    return;
                }
                i++;
            }
        }
    }
    
    public static void test2(String ruta) throws IOException, Exception {
        try (Reader reader = new BufferedReader(new FileReader(ruta))) {
            Lexer lex = new Lexer(reader);  // Crea un analizador léxico para el archivo
            Parser myParser = new Parser(lex);  // Crea un analizador sintáctico y le pasa el analizador léxico
            myParser.parse();  // Parsea el contenido del archivo
        }
    }
}


