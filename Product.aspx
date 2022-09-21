<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="LiquorApp.Product" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.MaintainScrollPositionOnPostBack = true;   // 讓頁面不會因按按鈕而跑到最上面
        if (!IsPostBack)
        {
            queryCondition.Text = "篩選條件:";
            if (Session["iLiquorName"].ToString() != "")
                queryCondition.Text += "<br />" + "名稱: " + Session["iLiquorName"].ToString();
            queryCondition.Text += "<br />" + "價格: $" + Session["iPriceLow"].ToString() + " ~ $" + Session["iPriceHigh"].ToString();
            if (Session["iType"].ToString() != "ALL" && Session["iType"].ToString() != "")
                queryCondition.Text += "<br />" + "類型: " + Session["iType"].ToString();
            queryCondition.Text += "<br />" + "酒精濃度: " + Session["iPercentLow"].ToString() + "% ~ " + Session["iPercentHigh"].ToString() + "%";
            if (Session["iTaste"].ToString() != "ALL" && Session["iTaste"].ToString() != "")
                queryCondition.Text += "<br />" + "關鍵詞: " + Session["iTaste"].ToString();
            if (Session["iBrand"].ToString() != "ALL" && Session["iBrand"].ToString() != "")
                queryCondition.Text += "<br />" + "品牌: " + Session["iBrand"].ToString();
            if (Session["iCountry"].ToString() != "ALL" && Session["iCountry"].ToString() != "")
                queryCondition.Text += "<br />" + "國家: " + Session["iCountry"].ToString();
            BindProductRepeater();
        }

    }//end page load function

    private void BindProductRepeater()
    {
        string connString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        String str = "";
        str = "SELECT Name , productID, Price, Taste, Type, Country, Brand, abv, Capacity, Ingredient, PS, imagePath " +
                " FROM db_table_product WHERE 1=1 AND Type NOT LIKE '%test%' AND " +
                " Price BETWEEN " + Session["iPriceLow"].ToString() + " AND " + Session["iPriceHigh"].ToString() +
                " AND abv BETWEEN " + Session["iPercentLow"].ToString() + " AND " + Session["iPercentHigh"].ToString();
        if (Session["iLiquorName"].ToString().Trim() != "")
            str += " AND Name LIKE '%" + Session["iLiquorName"].ToString().Trim() + "%'";
        if (Session["iType"].ToString() != "ALL" && Session["iType"].ToString() != "")
            str += " AND Type='" + Session["iType"].ToString() + "'";
        if (Session["iTaste"].ToString() != "ALL" && Session["iTaste"].ToString() != "")
            str += " AND Taste LIKE '%" + Session["iTaste"].ToString() + "%'";
        if (Session["iBrand"].ToString() != "ALL" && Session["iBrand"].ToString() != "")
            str += " AND Brand='" + Session["iBrand"].ToString() + "'";
        if (Session["iCountry"].ToString() != "ALL" && Session["iCountry"].ToString() != "")
            str += " AND Country='" + Session["iCountry"].ToString() + "' ";

        str += ddl_Order.SelectedValue.ToString();

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

    // 排序依據
    protected void OnOrderChanged(object sender, EventArgs e)
    {
        BindProductRepeater();
    }
    protected void AddtoCartClick(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;

        // insert data cart
        String sqlStr = "";
        int quantity = Convert.ToInt32((item.FindControl("tb_Quantity") as TextBox).Text);
        sqlStr = "INSERT INTO db_table_cart (userID, userName, productName, quantity) " +
                "VALUES ('" + Session["userID"] + "' , " +
                "        '" + Session["userName"] + "' , " +
                "        '" + (item.FindControl("lbl_name") as Label).Text.ToString() + "' , " +
                "        '" + quantity + "' )";
        UpdateDB(sqlStr);

        // update rest of product data to cart
        sqlStr = "";
        sqlStr = "UPDATE a " +
                " SET a.productID=b.productID, a.abv=b.abv, a.type=b.Type, a.imagePath=b.imagePath, a.price=b.Price " +
                " FROM db_table_cart a " +
                " INNER JOIN db_table_product b " +
                " ON a.ProductName=b.Name AND a.userID='" + Session["userID"] + "' ";
        UpdateDB(sqlStr);

        Response.Write("<script>alert('已加至購物車!');<" + "/script>");
    }
    protected void ShowProductDetails(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;

        bool getVisible = (item.FindControl("table1") as Table).Visible;
        if (getVisible == false)
            (item.FindControl("table1") as Table).Visible = true;
        else
            (item.FindControl("table1") as Table).Visible = false;
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
    protected void OnPageTopClick(object sender, EventArgs e)
    {
        Page.MaintainScrollPositionOnPostBack = false;  // 回到最上面後要再page load一次才會恢復至true
    }
    protected void OnQueryClick(object sender, EventArgs e)
    {
        Response.Redirect("Query.aspx");
    }
    protected void OnLogoutClick(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void OnCartClick(object sender, EventArgs e)
    {
        Response.Redirect("Cart.aspx");
    }
    protected void OnHomeClick(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void OnAccountClick(object sender, EventArgs e)
    {
        Response.Redirect("Account.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Product</title>
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

        .bottompage {
            display: block;
            float: right;
            padding-right: 10px;
            padding-left: 900px;
            position: fixed;
            right: 10px;
            bottom: 20px;
        }

        .size1of3 {
            display: inline;
            text-align: center;
            float: left;
            width: 33%;
            height: 750px;
        }

        .floatRight {
            display: inline;
            float: right;
            padding-top: 10px;
            padding-right: 30px;
            padding-bottom: 30px;
            padding-left: 920px;
        }
        .floatleft {
            display: inline;
            float: left;
            padding-top: 10px;
            padding-bottom: 30px;
            padding-left: 100px;
        }

        .query {
            padding-top: 20px;
            padding-left: 25px;
            font-size: 18px;
            text-decoration: underline;
            line-height: 1.3;
            font-family: Arial, Helvetica, sans-serif;
            border: 5px solid LemonChiffon;
        }

        h1 {
            display: block;
            background: rgba(0, 128, 0, 0.1);
            font-weight: bold;
            font-style: italic;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pa-top-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <div class="pa-header-address">
                            <h1>隨手一點，美酒到嘴邊</h1>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="pa-header-call">
                            <h1>Liquor Delivery System</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="query">
            <asp:Label ID="queryCondition" type="text" runat="server"></asp:Label>
        </div>
        <div class="floatleft">
            <asp:Button ID="btn_Query" runat="server" Text="更改篩選條件" OnClick="OnQueryClick" Width="125px" />
        </div>
        <div class="floatRight">
            <asp:Button ID="btn_Home" runat="server" Text="首頁" OnClick="OnHomeClick" Width="75px" />

            <asp:Button ID="btn_Cart" runat="server" Text="My購物車" OnClick="OnCartClick" Width="100px" />

            <asp:Button ID="btn_Account" runat="server" Text="帳戶" OnClick="OnAccountClick" Width="75px" />

            <asp:Button ID="btn_Logout" runat="server" Text="登出" OnClick="OnLogoutClick" Width="75px" />
        </div>

        <div class="floatRight">
            排序依據:
            <asp:DropDownList ID="ddl_Order" runat="server" AutoPostBack="true" OnSelectedIndexChanged="OnOrderChanged">
                <asp:ListItem Selected="True" Value=" ORDER BY Price ASC ">價格: 由低到高</asp:ListItem>
                <asp:ListItem Value=" ORDER BY Price DESC ">價格: 由高到低</asp:ListItem>
                <asp:ListItem Value=" ORDER BY abv ASC ">酒精濃度: 由低到高</asp:ListItem>
                <asp:ListItem Value=" ORDER BY abv DESC ">酒精濃度: 由高到低</asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Repeater ID="repeater1" runat="server">
            <ItemTemplate>
                <div class="size1of3">
                    <div class="product">
                        <div>
                            <img src="<%# Eval("imagePath").ToString().Trim() %>" />
                            <br />
                            <label>名稱: </label>
                            <asp:Label ID="lbl_name" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            <br />
                            <label>價格: </label>
                            $<asp:Label ID="lbl_price" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                            <br />
                            <label>酒精濃度: </label>
                            <asp:Label ID="lbl_abv" runat="server" Text='<%# Eval("abv") %>'></asp:Label>%
                                <br />
                            <label>類型: </label>
                            <asp:Label ID="lbl_type" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                            <br />
                            <label>加購數量:</label>
                            <asp:TextBox ID="tb_Quantity" runat="server" Text="1" Width="70px"></asp:TextBox>
                            <asp:Button ID="btn_addCart" runat="server" Text="加到購物車" OnClick="AddtoCartClick" Width="110px" />
                        </div>
                        <div>
                            <asp:Button ID="btn_Detail" runat="server" Text="介紹" OnClick="ShowProductDetails" Width="75px" />
                            <asp:Table ID="table1" runat="server" Visible="False"
                                GridLines="both" BorderColor="#800000" BorderWidth="2" Height="50px" HorizontalAlign="Center">
                                <asp:TableHeaderRow>
                                    <asp:TableHeaderCell>風味</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>國家</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>品牌</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>容量</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>主要成份</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>註解</asp:TableHeaderCell>
                                </asp:TableHeaderRow>
                                <asp:TableRow Height="120px">
                                    <asp:TableCell Text='<%# Eval("Taste") %>'></asp:TableCell>
                                    <asp:TableCell Text='<%# Eval("Country") %>'></asp:TableCell>
                                    <asp:TableCell Text='<%# Eval("Brand") %>'></asp:TableCell>
                                    <asp:TableCell Text='<%# Eval("Capacity") + "ML" %>'></asp:TableCell>
                                    <asp:TableCell Text='<%# Eval("Ingredient") %>'></asp:TableCell>
                                    <asp:TableCell Text='<%# Eval("PS") %>'></asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </div>
                </div>
                <br />
            </ItemTemplate>
        </asp:Repeater>
        <div class="bottompage">
            <asp:ImageButton ID="btn_pageTop" runat="server" ImageUrl="images/arrowtop.png" OnClick="OnPageTopClick" Width="100px" />
        </div>

    </form>
</body>
</html>
