<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- receber dados --%>
        <%
           int codigo;
           String nome, marca;
           double preco;

           codigo = Integer.parseInt(request.getParameter("codigo"));
           nome = request.getParameter("nome");
           marca = request.getParameter("marca");
           preco = Double.parseDouble(request.getParameter("preco"));


           try {
               // criar conexão
               Connection conecta = null;
               PreparedStatement st = null;
               Class.forName("com.mysql.cj.jdbc.Driver");
               conecta = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3307/aulas", "root", "");

               // Inserir os dados na tabela produto
               st = conecta.prepareStatement("insert into produto(codigo,nome,marca,preco) values(?,?,?,?)");
               st.setInt(1, codigo);
               st.setString(2, nome);
               st.setString(3, marca);
               st.setDouble(4, preco);

               st.executeUpdate();
               out.print("Produto cadastrado");
           } catch (Exception x) {
               out.print("Erro: " + x.getMessage());
           }
        %>
    </body>
</html>
