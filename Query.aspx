<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="LiquorApp.Query" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void OnSearchClick(object sender, EventArgs e)
    {
        // check 價格 和 酒精濃度 輸入是否為數字
        bool check_Price = true;
        if (!Regex.IsMatch(tb_PriceLow.Text, @"^[0-9]+$") || !Regex.IsMatch(tb_PriceHigh.Text, @"^[0-9]+$"))
        {
            check_Price = false;
        }
        bool check_Percent = true;
        if (!Regex.IsMatch(tb_PercentLow.Text, @"^[0-9]+$") || !Regex.IsMatch(tb_PercentHigh.Text, @"^[0-9]+$"))
        {
            check_Percent = false;
            // 輸入不能含小數點
        }
        if (check_Price == true && check_Percent == true)   // 檢查無誤
        {
            Session["iLiquorName"] = this.tb_LiquorName.Text.ToUpper().Trim();
            Session["iPriceLow"] = this.tb_PriceLow.Text.Trim();
            Session["iPriceHigh"] = this.tb_PriceHigh.Text.Trim();
            Session["iPercentLow"] = this.tb_PercentLow.Text.Trim();
            Session["iPercentHigh"] = this.tb_PercentHigh.Text.Trim();
            Session["iType"] = this.rbl_Type.SelectedValue;     // 單選
            Session["iTaste"] = this.ddl_Taste.SelectedValue;   // 單選
            Session["iBrand"] = this.ddl_Brand.SelectedValue;   // 單選
            Session["iCountry"] = this.ddl_Country.SelectedValue;   // 單選
            Response.Redirect("Product.aspx");

        }
        else if (check_Price == false && check_Percent == true)
        {
            Response.Write("<script>alert('價格輸入錯誤');window.history.back();<" + "/script>");
        }
        else if (check_Price == true && check_Percent == false)
        {
            Response.Write("<script>alert('酒精濃度輸入錯誤(請勿含小數點)');window.history.back();<" + "/script>");
        }
        else
        {
            Response.Write("<script>alert('價格和酒精濃度輸入錯誤');window.history.back();<" + "/script>");
        }
    }

    protected void OnLogoutClick(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx");
    }
    protected void OnAccountClick(object sender, EventArgs e)
    {
        Response.Redirect("Account.aspx");
    }
    protected void OnCartClick(object sender, EventArgs e)
    {
        Response.Redirect("Cart.aspx");
    }
    protected void OnHomeClick(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>查詢商品</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/font.css" />
    <link rel="stylesheet" href="assets/css/swiper.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <style>
        span {
            font-size: 20px;
        }

        .radiobtn {
            margin-right: 15px;
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
        <h1>查詢商品</h1>
        <div class="pa-main-header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-9 col-6">
                        <div class="pa-nav-bar">
                            <div class="pa-menu">
                                <ul>
                                    <li>
                                        <asp:Button ID="btn_Home" runat="server" Text="首頁" OnClick="OnHomeClick" Width="100px" /></li>
                                    <li>
                                        <asp:Button ID="btn_Account" runat="server" Text="My帳戶" OnClick="OnAccountClick" Width="100px" /></li>
                                    <li>
                                        <asp:Button ID="btn_Cart" runat="server" Text="My購物車" OnClick="OnCartClick" Width="100px" /></li>
                                    <li>
                                        <asp:Button ID="btn_Logout" runat="server" OnClick="OnLogoutClick" Text="登出" Width="100px" /></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="pa-checkout spacer-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="pa-bill-form">
                            <div>
                                <span>
                                    <b>名稱: </b>
                                </span>
                                <asp:TextBox ID="tb_LiquorName" runat="server" Width="200px"></asp:TextBox>
                            </div>
                            <div>
                                <span>
                                    <b>類型: </b>
                                </span>
                                <br />
                                <br />
                                <asp:RadioButtonList ID="rbl_Type" runat="server" RepeatDirection="Horizontal" CssClass="radiobtn" Width="291px">
                                    <asp:ListItem Selected="True" Value="ALL">ALL</asp:ListItem>
                                    <asp:ListItem Value="啤酒">啤酒</asp:ListItem>
                                    <asp:ListItem Value="威士忌">威士忌 </asp:ListItem>
                                    <asp:ListItem Value="調酒">調酒</asp:ListItem>
                                </asp:RadioButtonList><br />
                            </div>

                            <div>
                                <span>
                                    <b>最低價格: </b>
                                </span>
                                <b>$</b>
                                <asp:TextBox ID="tb_PriceLow" runat="server" Text="0" Width="200px"></asp:TextBox>
                            </div>
                            <div>
                                <span>
                                    <b>最高價格: </b>
                                </span>
                                <b>$</b>
                                <asp:TextBox ID="tb_PriceHigh" runat="server" Text="100000" Width="200px"></asp:TextBox>
                            </div>

                        <div>
                            <span>
                                <b>濃度下限: </b>
                            </span>
                            <asp:TextBox ID="tb_PercentLow" runat="server" Text="0" Width="200px"></asp:TextBox>
                            <b>%</b>
                        </div>
                        <div>
                            <span>
                                <b>濃度上限: </b>
                            </span>
                            <asp:TextBox ID="tb_PercentHigh" runat="server" Text="100" Width="200px"></asp:TextBox>
                            <b>%</b>
                        </div>
                        <div>
                            <span>
                                <b>品牌: </b>
                            </span>
                            <asp:DropDownList ID="ddl_Brand" runat="server" DataSourceID="SqlDataSource2" DataTextField="Brand" DataValueField="Brand" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="ALL">ALL</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DBConn %>" SelectCommand="SELECT DISTINCT [Brand] FROM [db_table_product] ORDER BY [Brand]"></asp:SqlDataSource>
                        </div>

                        <div>
                            <span>
                                <b>國家: </b>
                            </span>
                            <asp:DropDownList ID="ddl_Country" runat="server" DataSourceID="SqlDataSource1" DataTextField="Country" DataValueField="Country" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="ALL">ALL</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConn %>" SelectCommand="SELECT DISTINCT [Country] FROM [db_table_product] ORDER BY [Country]"></asp:SqlDataSource>
                        </div>
                        <br />

                        <div>
                            <span>
                                <b>關鍵詞: </b>
                            </span>
                            <asp:DropDownList ID="ddl_Taste" runat="server">
                                <asp:ListItem Selected="True">ALL</asp:ListItem>
                                <asp:ListItem>啤酒香</asp:ListItem>
                                <asp:ListItem>麥香</asp:ListItem>
                                <asp:ListItem>苦</asp:ListItem>
                                <asp:ListItem>評價</asp:ListItem>
                                <asp:ListItem>學生</asp:ListItem>
                                <asp:ListItem>清爽</asp:ListItem>
                                <asp:ListItem>無苦味</asp:ListItem>
                                <asp:ListItem>海鹽</asp:ListItem>
                                <asp:ListItem>番茄</asp:ListItem>
                                <asp:ListItem>粉紅色</asp:ListItem>
                                <asp:ListItem>甜</asp:ListItem>
                                <asp:ListItem>一杯就倒</asp:ListItem>
                                <asp:ListItem>咖啡</asp:ListItem>
                                <asp:ListItem>奶酒</asp:ListItem>
                                <asp:ListItem>檸檬</asp:ListItem>
                                <asp:ListItem>雞尾酒之后</asp:ListItem>
                                <asp:ListItem>不知道</asp:ListItem>
                                <asp:ListItem>酸甜</asp:ListItem>
                                <asp:ListItem>柳橙汁</asp:ListItem>
                                <asp:ListItem>香草</asp:ListItem>
                                <asp:ListItem>巧克力</asp:ListItem>
                                <asp:ListItem>肉桂</asp:ListItem>
                                <asp:ListItem>牛奶</asp:ListItem>
                                <asp:ListItem>蜂蜜</asp:ListItem>
                                <asp:ListItem>堅果</asp:ListItem>
                                <asp:ListItem>石楠花</asp:ListItem>
                                <asp:ListItem>圓潤醇厚</asp:ListItem>
                                <asp:ListItem>水果蜜餞</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <br />
                        </div>

                        <div>
                            <asp:Button ID="btn_Search" runat="server" OnClick="OnSearchClick" Text="查詢商品" Width="150px" />
                        </div>
                        <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
