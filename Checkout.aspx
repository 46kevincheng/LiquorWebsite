<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="LiquorApp.Checkout" %>

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
            String str = "";
            str = "SELECT name FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            SqlCommand sqlCmd = new SqlCommand(str, cnn);
            this.label_name.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            str = "SELECT phone FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.label_phone.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            str = "SELECT address FROM db_table_account WHERE id='" + Session["userID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.label_address.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();
            str = "SELECT orderID FROM db_table_order WHERE userID='" + Session["userID"] + "' AND orderID = '" + Session["orderID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            this.label_id.Text = sqlCmd.ExecuteScalar().ToString();
            sqlCmd.Dispose();

            str = "SELECT ProductName AS '商品名稱', price AS '單品價格', quantity AS '購買數量' FROM db_table_order " +
                    "WHERE userID = '" + Session["userID"] + "' AND orderID = '" + Session["orderID"] + "' ";
            sqlCmd = new SqlCommand(str, cnn);
            SqlDataReader dataReader = sqlCmd.ExecuteReader();
            GridView1.DataSource = dataReader;
            GridView1.DataBind();
            sqlCmd.Dispose();
            cnn.Close();

            // return total price of order
            cnn.Open();
            int totalPrice = 0;
            String ss = "";
            ss = "SELECT SUM(price*quantity) AS totalPrice" +
                    " FROM db_table_order" +
                    " WHERE userID='" + Session["userID"] + "' AND orderID='" + Session["orderID"] + "'";
            SqlCommand cmd = new SqlCommand(ss, cnn);
            totalPrice = Convert.ToInt32(cmd.ExecuteScalar());
            cmd.Dispose();
            total_price.Text += totalPrice.ToString();
            cnn.Close();
        }
    }
    protected void OnConfirmClick(object sender, EventArgs e)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection cnn = new SqlConnection(connectionString);
        cnn.Open();

        // check if user info is correct
        int checker = 0;
        String str = "";
        str = "SELECT COUNT(*) FROM db_table_account WHERE email = '" + tb_email.Text.Trim() + "'" +
              " AND password = '" + tb_password.Text.Trim() + "' AND id = '" + Session["userID"] + "' ";
        SqlCommand sqlCmd = new SqlCommand(str, cnn);
        checker = Convert.ToInt32(sqlCmd.ExecuteScalar());
        sqlCmd.Dispose();

        if (checker > 0)
        {
            // delete cart
            str = "DELETE a FROM db_table_cart a " +
                  " INNER JOIN db_table_order b on a.userID=b.userID " +
                  " WHERE b.orderID = '" + Session["orderID"] + "' AND a.productID=b.productID AND a.userID = b.userID ";
            SqlCommand cmd = new SqlCommand(str, cnn);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.DeleteCommand = new SqlCommand(str, cnn);
            adapter.DeleteCommand.ExecuteNonQuery();
            adapter.Dispose();
            cmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('已成功送出訂單!謝謝親愛的顧客~');<" + "/script>");
            Response.AppendHeader("Refresh", "0;url=Home.aspx");
        }
        else
        {
            cnn.Close();
            Response.Write("<script>alert('您輸入的信箱與密碼不符合此帳號資料!');<" + "/script>");
        }
    }
    protected void OnCancelClick(object sender, EventArgs e)
    {
        // delete order
        string connectionString = @"Data Source=LAPTOP-27BDJTVB;Initial Catalog=LiquorApp;Integrated Security=True";
        SqlConnection cnn = new SqlConnection(connectionString);
        cnn.Open();
        String str = "";
        str = "DELETE FROM db_table_order WHERE userID = '" + Session["userID"] + "' AND orderID = '" + Session["orderID"] + "' ";
        SqlCommand cmd = new SqlCommand(str, cnn);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.DeleteCommand = new SqlCommand(str, cnn);
        adapter.DeleteCommand.ExecuteNonQuery();
        adapter.Dispose();
        cmd.Dispose();
        cnn.Close();
        Response.Write("<script>alert('訂單已取消!');<" + "/script>");
        Response.AppendHeader("Refresh", "0;url=Cart.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>結帳</title>
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
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>結帳</h1>
        <div class="pa-checkout spacer-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="pa-bill-form">
                            <div>
                                <asp:Label ID="Label1" runat="server" Text="您這次購買的商品: " Font-Bold="True" Font-Size="Large"></asp:Label>
                            </div>
                            <div>
                                <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                            </div>
                            <div>
                                <asp:Label ID="total_price" runat="server" Text="總價格: " Font-Bold="True" Font-Size="Large"></asp:Label>
                            </div>
                            <div>
                                <br />
                                送貨地點將送達以下收件地址，到貨時將聯絡以下電話號碼。
                                <br />
                                請確認以下資料皆正確，若有需要修改請按取消訂單，並至帳戶修改資料。
                            </div>
                            <div>
                                <span>我的名稱: </span>
                                <asp:Label ID="label_name" runat="server" Text=""></asp:Label><br />

                                <span>下單人聯絡電話: </span>
                                <asp:Label ID="label_phone" runat="server" Text=""></asp:Label><br />

                                <span>取貨地址: </span>
                                <asp:Label ID="label_address" runat="server" Text=""></asp:Label><br />

                                <span>本訂單編號ID: </span>
                                <asp:Label ID="label_id" runat="server" Text=""></asp:Label><br />

                            </div>
                            <br />
                            <div>
                                請填寫以下資料以確保您是此帳號本人
                            </div>
                            <div>
                                <span>信箱:</span>
                                <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>密碼:</span>
                                <asp:TextBox ID="tb_password" runat="server" type="password"></asp:TextBox>
                            </div>
                            <div>
                                <asp:Button ID="btn_Confirm" runat="server" Text="確認下單" OnClick="OnConfirmClick" />
                            </div>
                            <div>
                                <asp:Button ID="btn_Cart" runat="server" Text="取消" OnClick="OnCancelClick" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
