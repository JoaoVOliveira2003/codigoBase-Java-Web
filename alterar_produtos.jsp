<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salvar Alterações</title>
    </head>
    <body>
        <%
            int codigo = Integer.parseInt(request.getParameter("codigo"));
            String nome = request.getParameter("nome");
            String marca = request.getParameter("marca");
            double preco = Double.parseDouble(request.getParameter("preco"));

            try {
                // Criar conexão
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3307/aulas", "root", "");

                // Atualizar dados na tabela produto
                PreparedStatement st = conecta.prepareStatement(
                    "UPDATE produto SET nome = ?, marca = ?, preco = ? WHERE codigo = ?"
                );
                st.setString(1, nome);
                st.setString(2, marca);
                st.setDouble(3, preco);
                st.setInt(4, codigo);

                st.executeUpdate();

                out.print("<p>Produto atualizado com sucesso!</p>");
                st.close();
                conecta.close();
            } catch (Exception e) {
                out.print("<p>Erro ao atualizar o produto: " + e.getMessage() + "</p>");
            }
        %>
        <a href="listar.jsp">Voltar para a lista de produtos</a>
    </body>
</html>
