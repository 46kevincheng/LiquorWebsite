<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="LiquorApp.Cart" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindProductRepeater();
        }

    }

    private void BindProductRepeater()
    {
        string connString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        String str = "";
        str = "SELECT imagePath, productID, ProductName, price, abv, type, quantity FROM db_table_cart WHERE userID = '" + Session["userID"] + "'";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            using (SqlCommand sqlCmd = new SqlCommand(str, conn))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(sqlCmd))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    repeater1.DataSource = dt;
                    repeater1.DataBind();
                }
            }
        }
    }

    protected void OnCheckoutClick(object sender, EventArgs e)
    {
        // get orderID
        string connString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection sqlcnn = new SqlConnection(connString);
        sqlcnn.Open();
        String str = "SELECT MAX(orderID) FROM db_table_order ";
        SqlCommand sqlCmd = new SqlCommand(str, sqlcnn);
        int maxOrder = 0;
        maxOrder = Convert.ToInt32(sqlCmd.ExecuteScalar());
        maxOrder++;
        Session["orderID"] = maxOrder;
        sqlCmd.Dispose();
        sqlcnn.Close();

        for (int i = 0; i < repeater1.Items.Count; i++)
        {
            CheckBox chk = (CheckBox)repeater1.Items[i].FindControl("checkbox1");
            if (chk.Checked)
            {
                Label pName = (Label)repeater1.Items[i].FindControl("lbl_ProductName");
                int quantity = Convert.ToInt32((repeater1.Items[i].FindControl("tb_Quantity") as TextBox).Text);
                String insertStr = "";
                insertStr = "INSERT INTO db_table_order (userID, orderID, userName, productName, status, quantity) " +
                        " VALUES ('" + Session["userID"] + "' , " +
                        " '" + Session["orderID"] + "' , " +
                        " '" + Session["userName"] + "' , " +
                        " '" + pName.Text.ToString() + "' , " +
                        " '尚未出貨' , " +
                        " '" + quantity + "') ";
                UpdateDB(insertStr);
                String sqlStr = "";
                sqlStr = "UPDATE a " +
                        " SET a.productID=b.productID ,  a.price=b.price " +
                        " FROM db_table_order a  INNER JOIN db_table_cart b  " +
                        " ON a.ProductName=b.ProductName AND " +
                        "a.userID='" + Session["userID"] + "' AND a.orderID = '" + Session["orderID"] + "' ";
                UpdateDB(sqlStr);
                sqlStr = "";
                sqlStr = "UPDATE a " +
                        " SET a.email=b.email ,  a.phone=b.phone , a.address=b.address" +
                        " FROM db_table_order a INNER JOIN db_table_account b " +
                        " ON a.userID=b.id";
                UpdateDB(sqlStr);
            }
        }

        Response.Write("<script>alert('請您在結帳頁確認身分並且點選確認或取消訂單!');<" + "/script>");
        Response.AppendHeader("Refresh", "0;url=Checkout.aspx");
    }
    public void UpdateDB(string sqlStr)
    {
        string connString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection sqlcnn = new SqlConnection(connString);
        sqlcnn.Open();
        SqlCommand cmd = new SqlCommand(sqlStr, sqlcnn);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.InsertCommand = new SqlCommand(sqlStr, sqlcnn);
        adapter.InsertCommand.ExecuteNonQuery();
        adapter.Dispose();
        cmd.Dispose();
        sqlcnn.Close();
    }
    protected void OnRemoveClick(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;
        string deleteStr = " DELETE FROM db_table_cart WHERE userID = '" + Session["userID"] + "' " +
            " AND ProductName = '" + (item.FindControl("lbl_ProductName") as Label).Text.ToString() + "' ";
        UpdateDB(deleteStr);
        Response.Write("<script>alert('商品移除!');<" + "/script>");
        BindProductRepeater();
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
    protected void OnAccountClick(object sender, EventArgs e)
    {
        Response.Redirect("Account.aspx");
    }
    protected void OnLogoutClick(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>購物車</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/font.css" />
    <link rel="stylesheet" href="assets/css/swiper.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <style>
        .product {
            box-shadow: 0px 0px 30px 10px rgba(224, 184, 204, 0.2);
            text-align: center;
            border-radius: 10px;
            position: relative;
            transition: 0.3s;
            margin-bottom: 100px;
            margin-top: 10px;
        }

        img {
            width: 200px;
            height: 300px;
            object-fit: contain;
        }

        .size1of3 {
            display: inline;
            text-align: center;
            float: left;
            width: 33%;
            height: 700px;
        }

        .floatRight {
            display: inline;
            float: right;
            padding-top: 10px;
            padding-right: 30px;
            padding-bottom: 30px;
            padding-left: 850px;
        }

        .floatcheck {
            display: inline;
            float: left;
            padding-left: 150px;
            padding-top: 40px;
            padding-bottom: 30px;
        }

        .checkbox {
            display: inline;
            position: relative;
            text-align: center;
        }

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
        <h1>My購物車</h1>
        <div class="floatcheck">
            <asp:Button ID="btn_Checkout" runat="server" Text="結帳" OnClick="OnCheckoutClick" Width="124px" />
        </div>
        <div class="floatRight">
            <asp:Button ID="btn_Home" runat="server" Text="首頁" OnClick="OnHomeClick" Width="75px" />

            <asp:Button ID="btn_Query" runat="server" Text="查詢商品" OnClick="OnQueryClick" Width="100px" />

            <asp:Button ID="btn_Product" runat="server" Text="商品" OnClick="OnProductClick" Width="75px" />

            <asp:Button ID="btn_Account" runat="server" Text="My帳戶" OnClick="OnAccountClick" Width="100px" />

            <asp:Button ID="btn_Logout" runat="server" Text="登出" OnClick="OnLogoutClick" Width="75px" />
        </div>

        <asp:Repeater ID="repeater1" runat="server">
            <ItemTemplate>
                <div class="size1of3">
                    <div class="product">
                        <img src="<%# Eval("imagePath").ToString().Trim() %>" />
                        <br />
                        <label>名稱: </label>
                        <asp:Label ID="lbl_ProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                        <br />
                        <asp:Table ID="table1" runat="server"
                            GridLines="both" BorderColor="#800000" BorderWidth="2" Height="50px" HorizontalAlign="Center" Width="295px">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell>單品價格</asp:TableHeaderCell>
                                <asp:TableHeaderCell>酒精濃度</asp:TableHeaderCell>
                                <asp:TableHeaderCell>類型</asp:TableHeaderCell>
                            </asp:TableHeaderRow>
                            <asp:TableRow>
                                <asp:TableCell Text='<%# "$" + Eval("price") %>'></asp:TableCell>
                                <asp:TableCell Text='<%# Eval("abv") + "%" %>'></asp:TableCell>
                                <asp:TableCell Text='<%# Eval("type") %>'></asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <label class="buy">加購數量:</label>
                        <asp:TextBox ID="tb_Quantity" runat="server" Text='<%# Eval("quantity") %>' Width="70px"></asp:TextBox><br />
                        <div class="checkbox">
                            <asp:CheckBox ID="checkbox1" runat="server" Checked="True" Width="20px" />
                        </div>
                        <div>
                            <label class="checkbox">勾選購買</label>
                        </div>
                        <asp:Button ID="btn_remove" runat="server" Text="移除商品" OnClick="OnRemoveClick" Width="100px" Style="float: right" /><br />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
