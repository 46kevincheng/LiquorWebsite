<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="LiquorApp.Account" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            // NAME
            String str = "SELECT name FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            SqlCommand sqlCmd = new SqlCommand(str, cnn);
            this.tb_name.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            // PHONE
            str = "SELECT phone FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.tb_phone.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            // ADDRESS
            str = "SELECT address FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.tb_address.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            // ID
            this.label_userID.Text = Session["userID"].ToString();
            // EMAIL
            str = "SELECT email FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.label_email.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            // PASSWORD
            str = "SELECT password FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.tb_password.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();

            str = "SELECT orderID AS '訂單ID', userName AS '下單人名稱', ProductName AS '商品名稱', price AS '單品價格'," +
                    " quantity AS '購買數量', email AS '信箱', phone AS '連絡電話', address AS '取貨地址' FROM db_table_order " +
                    "WHERE userID = '" + Session["userID"] + "' ORDER BY orderID ";
            sqlCmd = new SqlCommand(str, cnn);
            SqlDataReader dataReader = sqlCmd.ExecuteReader();
            GridView1.DataSource = dataReader;
            GridView1.DataBind();
            sqlCmd.Dispose();
            cnn.Close();

            cnn.Close();
        }
    }
    public void UpdateDB(string insertStr)
    {
        string connString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection sqlcnn = new SqlConnection(connString);
        sqlcnn.Open();
        SqlCommand cmd = new SqlCommand(insertStr, sqlcnn);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.InsertCommand = new SqlCommand(insertStr, sqlcnn);
        adapter.InsertCommand.ExecuteNonQuery();
        adapter.Dispose();
        cmd.Dispose();
        sqlcnn.Close();
    }
    protected void OnPassClick(object sender, EventArgs e)
    {
        if (tb_password.Text.Trim() == tb_confirm.Text.Trim())
        {
            String insertStr = "";
            insertStr = "UPDATE db_table_account SET password = '" + tb_password.Text.Trim() + "' " +
                        "WHERE id = '" + Session["userID"] + "' ";
            UpdateDB(insertStr);
            Response.Write("<script>alert('密碼更改成功!');<" + "/script>");
            Response.AppendHeader("Refresh", "0;url=Account.aspx");
        }
        else
        {
            Response.Write("<script>alert('請確認新密碼輸入無誤!');<" + "/script>");
        }
    }
    protected void OnNameClick(object sender, EventArgs e)
    {
        String insertStr = "";
        insertStr = "UPDATE db_table_account SET name = '" + tb_name.Text.Trim() + "' " +
                    "WHERE id = '" + Session["userID"] + "' ";
        UpdateDB(insertStr);
        Response.Write("<script>alert('名字更改成功!');<" + "/script>");
        Response.AppendHeader("Refresh", "0;url=Account.aspx");
    }
    protected void OnPhoneClick(object sender, EventArgs e)
    {
        String insertStr = "";
        insertStr = "UPDATE db_table_account SET phone = '" + tb_phone.Text.Trim() + "' " +
                    "WHERE id = '" + Session["userID"] + "' ";
        UpdateDB(insertStr);
        Response.Write("<script>alert('電話號碼更改成功!');<" + "/script>");
        Response.AppendHeader("Refresh", "0;url=Account.aspx");
    }
    protected void OnAddressClick(object sender, EventArgs e)
    {
        String insertStr = "";
        insertStr = "UPDATE db_table_account SET address = '" + tb_address.Text.Trim() + "' " +
                    "WHERE id = '" + Session["userID"] + "' ";
        UpdateDB(insertStr);
        Response.Write("<script>alert('地址更改成功!');<" + "/script>");
        Response.AppendHeader("Refresh", "0;url=Account.aspx");
    }
    protected void OnQueryClick(object sender, EventArgs e)
    {
        Response.Redirect("Query.aspx");
    }
    protected void OnProductClick(object sender, EventArgs e)
    {
        Response.Redirect("Product.aspx");
    }
    protected void OnHomeClick(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void OnLogoutClick(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void OnCartClick(object sender, EventArgs e)
    {
        Response.Redirect("Cart.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>帳戶</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/font.css" />
    <link rel="stylesheet" href="assets/css/swiper.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <link rel="shortcut icon" href="assets/images/fav.png" type="image/x-icon" />
    <style>
        span {
            font-size: 20px;
        }

        h2 {
            padding-top: 25px;
            padding-bottom: 25px;
            font-size: 40px;
            text-align: center;
        }

        h1 {
            display: block;
            background: rgba(0, 128, 0, 0.1);
            font-weight: bold;
            font-style: italic;
        }

        .grid {
            text-align: center;
            padding-left: 450px;
            margin-bottom: 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>我的帳戶</h1>

        <div class="pa-main-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-9 col-6">
                        <div class="pa-nav-bar">
                            <div class="pa-menu">
                                <ul>
                                    <li>
                                        <asp:Button ID="btn_Home" runat="server" Text="首頁" OnClick="OnHomeClick" />
                                    </li>
                                    <li>
                                        <asp:Button ID="btn_Query" runat="server" Text="查詢商品" OnClick="OnQueryClick" />
                                    </li>
                                    <li>
                                        <asp:Button ID="btn_Product" runat="server" Text="商品" OnClick="OnProductClick" />
                                    </li>
                                    <li>
                                        <asp:Button ID="btn_Cart" runat="server" Text="My購物車" OnClick="OnCartClick" />
                                    </li>
                                    <li>
                                        <asp:Button ID="btn_Logout" runat="server" Text="登出" OnClick="OnLogoutClick" />
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="pa-checkout spacer-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="pa-bill-form">
                            <div>
                                <span>我的使用者ID: </span>
                                <asp:Label ID="label_userID" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div>
                                <span>信箱: </span>
                                <asp:Label ID="label_email" runat="server" Text="Label"></asp:Label>
                            </div>
                            <br />
                            <div>
                                <span>密碼: </span>
                                <asp:TextBox ID="tb_password" type="password" runat="server"></asp:TextBox>
                                <span>確認新密碼: </span>
                                <asp:TextBox ID="tb_confirm" type="password" runat="server"></asp:TextBox>
                                <asp:Button ID="btn_changePassword" runat="server" Text="改密碼" OnClick="OnPassClick" />
                            </div>
                            <div>
                                <span>名字: </span>
                                <asp:TextBox ID="tb_name" runat="server"></asp:TextBox>
                                <asp:Button ID="btn_changeName" runat="server" Text="改名" OnClick="OnNameClick" />
                            </div>
                            <div>
                                <span>電話: </span>
                                <asp:TextBox ID="tb_phone" runat="server"></asp:TextBox>
                                <asp:Button ID="btn_changePhone" runat="server" Text="改電話號碼" OnClick="OnPhoneClick" />
                            </div>
                            <div>
                                <span>地址: </span>
                                <asp:TextBox ID="tb_address" runat="server"></asp:TextBox>
                                <asp:Button ID="btn_changeAddress" runat="server" Text="改地址" OnClick="OnAddressClick" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <h2>我過去的訂單</h2>
        <div class="grid">
            <asp:GridView ID="GridView1" runat="server" BorderColor="#009933" BorderStyle="Ridge"></asp:GridView>
        </div>
    </form>
</body>
</html>

