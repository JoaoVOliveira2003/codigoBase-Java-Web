<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir Produto</title>
    </head>
    <body>
        <%
        int cod = Integer.parseInt(request.getParameter("codigo"));

        try {
            // Carregando o driver e conectando ao banco
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3307/aulas", "root", "");

            // Preparando o comando SQL para excluir
            PreparedStatement st = conecta.prepareStatement("DELETE FROM produto WHERE codigo=?");
            st.setInt(1, cod);

            // Executando a exclusão e verificando o resultado
            int resultado = st.executeUpdate();

            if (resultado == 0) {
                out.println("Produto não excluído.");
            } else {
                out.println("Produto excluído.");
            }

            // Fechando recursos
            st.close();
            conecta.close();
        } catch (Exception e) {
            out.println("Erro ao processar a solicitação.");
        }
        %>
    </body>
</html>
