<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Produto</title>
    </head>
    <body>
        <%
            // Recupera o código do produto enviado como parâmetro
            int cod = Integer.parseInt(request.getParameter("codigo"));

            try {
                // Conectando ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3307/aulas", "root", "");

                // Preparando o comando SQL para buscar o produto
                PreparedStatement st = conecta.prepareStatement("SELECT * FROM produto WHERE codigo=?");
                st.setInt(1, cod);
                ResultSet resultado = st.executeQuery();

                if (!resultado.next()) {
                    // Caso o produto não seja encontrado
                    out.println("<p>Produto não encontrado.</p>");
                } else {
                    // Caso o produto seja encontrado, exibe o formulário preenchido
        %>
          
        <h1>Alterar Produto</h1>
        <form method="post" action="alterar_produtos.jsp">
            <p>
                <label for="codigo">Código:</label>
                <input type="text" id="codigo" name="codigo" readonly value="<%= resultado.getString("codigo") %>" readonly>
            </p>
            <p>
                <label for="nome">Nome do Produto:</label>
                <input type="text" id="nome" name="nome" value="<%= resultado.getString("nome") %>">
            </p>
            <p>
                <label for="marca">Marca:</label>
                <input type="text" id="marca" name="marca" value="<%= resultado.getString("marca") %>">
            </p>    
            <p>
                <label for="preco">Preço:</label>
                <input type="text" id="preco" name="preco" value="<%= resultado.getString("preco") %>">
            </p>   
            <p>
                <input type="submit" value="Salvar Alterações">
            </p>        
        </form>

        <%
                }
                // Fechando recursos
                resultado.close();
                st.close();
                conecta.close();
            } catch (Exception e) {
                out.println("<p>Erro ao processar a solicitação: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
