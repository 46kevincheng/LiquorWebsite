<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckOrder.aspx.cs" Inherits="LiquorApp.CheckOrder" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            String str = "";
            str = "SELECT * FROM db_table_order WHERE orderID > 0 ORDER BY userID, orderID, productID";
            CheckDB(str);
        }
    }
    public void CheckDB(string sqlStr)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection cnn = new SqlConnection(connectionString);
        cnn.Open();
        SqlCommand sqlCmd = new SqlCommand(sqlStr, cnn);
        SqlDataReader dataReader = sqlCmd.ExecuteReader();
        GridView1.DataSource = dataReader;
        GridView1.DataBind();
        sqlCmd.Dispose();
        cnn.Close();
    }
    protected void OnQueryClick(object sender, EventArgs e)
    {
        String str = "";
        str = "SELECT * FROM db_table_order WHERE orderID > 0 ";
        if (userID.Text != "")
        {
            str += " AND userID = '" + userID.Text.Trim() + "' ";
        }
        if (orderID.Text != "")
        {
            str += " AND orderID = '" + orderID.Text.Trim() + "' ";
        }
        if (productID.Text != "")
        {
            str += " AND productID = '" + productID.Text.Trim() + "' ";
        }
        str += " ORDER BY userID, orderID, productID";
        CheckDB(str);
    }
    protected void OnHomeClick(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>查詢訂單</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/font.css" />
    <link rel="stylesheet" href="assets/css/swiper.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <style>
        h1 {
            display: block;
            background: rgba(0, 128, 0, 0.1);
            font-weight: bold;
            font-style: italic;
        }

        h2 {
            display: block;
            background: rgba(204, 230, 255, 0.8);
            font-weight: bold;
            font-style: italic;
        }

        .home {
            padding-left: 900px;
        }

        .search {
            padding-left: 100px;
        }

        .grid {
            padding-left: 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>管理員專用</h1>
        <h2>查看所有訂單</h2>
        <div class="home">
            <asp:Button ID="btn_Home" runat="server" Text="首頁" OnClick="OnHomeClick" Width="75px" />
        </div>
        <div class="search">
            <asp:Label Width="90px" type="text" runat="server">userID: </asp:Label>
            <asp:TextBox ID="userID" type="text" runat="server" Width="100px"></asp:TextBox><br />
            <asp:Label Width="90px" type="text" runat="server">orderID: </asp:Label>
            <asp:TextBox ID="orderID" type="text" runat="server" Width="100px"></asp:TextBox><br />
            <asp:Label Width="90px" type="text" runat="server">productID: </asp:Label>
            <asp:TextBox ID="productID" type="text" runat="server" Width="100px"></asp:TextBox><br />
            <asp:Label Width="500px" type="text" runat="server"></asp:Label>
            <asp:Button ID="btn_Query" runat="server" Text="查詢訂單" OnClick="OnQueryClick" Width="100px" />
            <br />
            <br />
        </div>
        <div class="grid">
            <asp:GridView ID="GridView1" runat="server" BorderColor="#FF9933" BorderStyle="Groove" BorderWidth="3px" >
            </asp:GridView>
        </div>
    </form>
</body>
</html>
