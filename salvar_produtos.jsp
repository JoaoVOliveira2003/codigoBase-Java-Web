<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Produtos</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <h1>Lista de Produtos</h1>
        <%
           try {
               // Criar conexão
               Class.forName("com.mysql.cj.jdbc.Driver");
               Connection conecta = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3307/aulas", "root", "");

               // Consultar os dados na tabela produto
               PreparedStatement st = conecta.prepareStatement("SELECT * FROM produto");
               ResultSet rs = st.executeQuery();
        %>               
        <table>
            <tr>
                <th>Código</th>
                <th>Nome</th>
                <th>Marca</th>
                <th>Preço</th>
                <th>excluir</th>
                <th>altera</th>
            </tr>
            <%
               while (rs.next()) {   
            %>
            <tr>
                <td><%= rs.getString("codigo") %></td>
                <td><%= rs.getString("nome") %></td>
                <td><%= rs.getString("marca") %></td>
                <td><%= rs.getString("preco") %></td>
                <td><a href="excluir_produto.jsp?codigo=<%= rs.getString("codigo") %>">Excluir</a></td>
                <td><a href="carregaproduto.jsp?codigo=<%= rs.getString("codigo") %>">Alterar</a></td>

            </tr>
            <%
               } // Fim do while
            %>
        </table>
        <%
               rs.close();
               st.close();
               conecta.close();
           } catch (Exception x) {
               out.print("Erro: " + x.getMessage());
           }
        %>
    </body>
</html>
