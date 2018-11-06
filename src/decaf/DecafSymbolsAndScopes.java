package decaf;

import java.util.ArrayList;
import java.util.Collections;
import org.antlr.symtab.FunctionSymbol;
import org.antlr.symtab.GlobalScope;
import org.antlr.symtab.LocalScope;
import org.antlr.symtab.Scope;
import org.antlr.symtab.VariableSymbol;
import org.antlr.symtab.Symbol;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.ParseTreeProperty;

import decaf.DecafParser.StatementContext;


/**
 * This class defines basic symbols and scopes for Decaf language
 */
public class DecafSymbolsAndScopes extends DecafParserBaseListener {
    ParseTreeProperty<Scope> scopes = new ParseTreeProperty<Scope>();
    ArrayList<String> varlist = new ArrayList();
    ArrayList<String> metlist = new ArrayList();
    ArrayList<String> paramlist = new ArrayList();
    GlobalScope globals;
    Scope currentScope; // define symbols in this scope
    String sup = "vazio";

    @Override
    public void enterProgram(DecafParser.ProgramContext ctx) {
        globals = new GlobalScope(null);
        pushScope(globals);
    }

    @Override
    public void exitProgram(DecafParser.ProgramContext ctx) {
        if(metlist.contains("main") == false){
            error(ctx.CLASS().getSymbol(), "Classe sem método main");
        }
        popScope();
        System.out.println(globals);
        
    }
    
    @Override
    public void enterVar_declaration(DecafParser.Var_declarationContext ctx) {
        for(int i = 0; i < ctx.ID().size(); i++){
            sup = ctx.ID(i).getSymbol().getText();
            if(varlist.contains(sup) == true){
                error(ctx.ID(i).getSymbol(), "Variável com nome duplicado");
            }else{
                varlist.add(sup);
                defineVar(ctx.type(), ctx.ID(i).getSymbol());
            } 
        }
    }
    @Override
    public void enterStatement(StatementContext ctx) {
        
    }
	
	@Override
    public void exitStatement(DecafParser.StatementContext ctx) {
        
        if(varlist.contains(sup) == false){
            error(ctx.location().ID().getSymbol(), "Variável não declarada");
        }

    }
    @Override
    public void enterMethod(DecafParser.MethodContext ctx) {
        String name = ctx.ID().getText();

        // push new scope by making new one that points to enclosing scope
        FunctionSymbol function = new FunctionSymbol(name);

        currentScope.define(function); // Define function in current scope
        saveScope(ctx, function);
        pushScope(function);
     }
	
    @Override
    public void exitMethod(DecafParser.MethodContext ctx) { 
        metlist.add(ctx.ID().getSymbol().getText());
        popScope();
    }

    @Override
    public void enterBlock(DecafParser.BlockContext ctx) {
        LocalScope l = new LocalScope(currentScope);
        saveScope(ctx, currentScope);
        pushScope(l);
    }

    @Override
    public void exitBlock(DecafParser.BlockContext ctx) {
        popScope();
    }
    @Override
    public void enterDeclaration(DecafParser.DeclarationContext ctx) { 
    }
	
    @Override 
    public void exitDeclaration(DecafParser.DeclarationContext ctx) {
        for(int i = 0; i < ctx.method_type().size(); i++){
            sup = ctx.method_type(i).ID().getSymbol().getText();
            if(varlist.contains(sup) == true){
                error(ctx.method_type(i).ID().getSymbol(), "Variável com nome duplicado");
            }else{
                for (int j = 0; j < ctx.int_literal().size(); j++) {
                    if (Integer.parseInt(ctx.int_literal(j).INTLITERAL().getSymbol().getText()) > 0) {
                        varlist.add(sup);
                    }else{
                        error(ctx.method_type(i).ID().getSymbol(), "Tamanho do vetor inválido");
                    }
                }
                
            } 
        }
    }

    void defineVar(DecafParser.TypeContext typeCtx, Token nameToken) {
        VariableSymbol var = new VariableSymbol(nameToken.getText());
        currentScope.define(var); // Define symbol in current scope
    }



    
    /**
     * Método que atualiza o escopo para o atual e imprime o valor
     *
     * @param s
     */

    private void pushScope(Scope s) {
        currentScope = s;
        System.out.println("entering: "+currentScope.getName()+":"+s);
    }

    /**
     * Método que cria um novo escopo no contexto fornecido
     *
     * @param ctx
     * @param s
     */
    void saveScope(ParserRuleContext ctx, Scope s) {
        scopes.put(ctx, s);
    }

    /**
     * Muda para o contexto superior e atualia o escopo
     */
    private void popScope() {
        System.out.println("leaving: "+currentScope.getName()+":"+currentScope);
        currentScope = currentScope.getEnclosingScope();
    }

    public static void error(Token t, String msg) {
        System.err.printf("line %d:%d %s\n", t.getLine(), t.getCharPositionInLine(),
                msg);
    }

    /**
     * Valida tipos encontrados na linguagem para tipos reais
     *
     * @param tokenType
     * @return
     */
    public static DecafSymbol.Type getType(int tokenType) {
        switch ( tokenType ) {
            case DecafParser.VOID :  return DecafSymbol.Type.tVOID;
            case DecafParser.INTLITERAL :   return DecafSymbol.Type.tINT;
        }
        return DecafSymbol.Type.tINVALID;
    }


}
