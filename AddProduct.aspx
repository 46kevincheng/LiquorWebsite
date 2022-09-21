<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="LiquorApp.AddProduct" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void OnAddClick(object sender, EventArgs e)
    {
        if (CheckEmptyString() == false)    // if no empty textbox
        {
            // get productID
            string connectionString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            String str = "SELECT MAX(productID) FROM db_table_product ";
            SqlCommand sqlCmd = new SqlCommand(str, cnn);
            int maxID = 0;
            maxID = Convert.ToInt32(sqlCmd.ExecuteScalar());
            maxID++;
            sqlCmd.Dispose();
            cnn.Close();

            // insert product to DB
            String insertStr = "";
            insertStr = "INSERT INTO db_table_product (Name,Price,Taste,Type,Country,Brand,abv,Capacity,Ingredient,PS,productID,imagePath) " +
                    " VALUES ('" + Name.Text.ToString() + "' , " +
                    " '" + Price.Text + "' , " +
                    " '" + Taste.Text.ToString() + "' , " +
                    " '" + Type.Text.ToString() + "' , " +
                    " '" + Country.Text.ToString() + "' , " +
                    " '" + Brand.Text.ToString() + "' , " +
                    " '" + abv.Text + "' , " +
                    " '" + Capacity.Text + "' , " +
                    " '" + Ingredient.Text.ToString() + "' , " +
                    " '" + PS.Text.ToString() + "' , " +
                    " '" + maxID + "' , " +
                    " '" + imagePath.Text.ToString() + "') ";
            UpdateDB(insertStr);
            Response.Write("<script>alert('商品新增成功!');window.history.back();<" + "/script>");

        }

    }
    protected bool CheckEmptyString()
    {
        // check for empty textbox
        bool checkEmpty = false;
        if (Name.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫名稱');window.history.back();<" + "/script>");
        }
        else if (Price.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫價格');window.history.back();<" + "/script>");
        }
        else if (Taste.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫風味');window.history.back();<" + "/script>");
        }
        else if (Type.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫類型');window.history.back();<" + "/script>");
        }
        else if (abv.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫濃度');window.history.back();<" + "/script>");
        }
        else if (Capacity.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫容量');window.history.back();<" + "/script>");
        }
        else if (Ingredient.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫成份');window.history.back();<" + "/script>");
        }
        else if (imagePath.Text == "")
        {
            checkEmpty = true;
            Response.Write("<script>alert('您尚未填寫圖片路徑');window.history.back();<" + "/script>");
        }
        else
        {
            if (Country.Text == "")
                Country.Text = "N/A";
            if (Brand.Text == "")
                Brand.Text = "N/A";
            if (PS.Text == "")
                PS.Text = "N/A";
        }
        return checkEmpty;
    }
    protected void OnDeleteClick(object sender, EventArgs e)
    {
        if (ddl_DeleteItem.SelectedValue != "None")
        {
            string deleteStr = "DELETE FROM db_table_product WHERE Name = '" + ddl_DeleteItem.SelectedValue.ToString() + "' ";
            UpdateDB(deleteStr);
            Response.Write("<script>alert('刪除商品成功');window.history.back();<" + "/script>");
        }
        else
        {
            Response.Write("<script>alert('請選擇欲刪除商品名稱');window.history.back();<" + "/script>");
        }
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
    protected void OnQueryClick(object sender, EventArgs e)
    {
        Response.Redirect("Query.aspx");
    }
    protected void OnHomeClick(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void OnProductClick(object sender, EventArgs e)
    {
        Response.Redirect("Product.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新增移除商品</title>
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
            background: rgba(0, 128, 0, 0.1);
            font-weight: bold;
            font-style: italic;
        }

        .btn {
            padding-left: 1100px;
        }

        .add {
            padding-left: 50px;
            padding-top: 30px;
            padding-bottom: 20px;
        }

        .remove {
            padding-left: 50px;
            padding-top: 30px;
            padding-bottom: 20px;
        }
        .button{
            margin-top:10px;
            padding-bottom: 5px;
            margin-left:100px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>管理員專用</h1>
        <h2>商品新增</h2>
        <div class="btn">
            <asp:Button ID="btn_Home" runat="server" Text="首頁" OnClick="OnHomeClick" Width="100px" />
            <asp:Button ID="btn_Query" runat="server" Text="查詢商品" OnClick="OnQueryClick" Width="100px" />
            <asp:Button ID="btn_Product" runat="server" Text="商品" OnClick="OnProductClick" Width="100px" />
        </div>
        <div class="add">
            名稱:
            <asp:TextBox ID="Name" type="text" runat="server" Width="150px"></asp:TextBox><br />
            價格:
            <asp:TextBox ID="Price" type="text" runat="server" Width="150px"></asp:TextBox><br />
            類型:
            <asp:TextBox ID="Type" type="text" runat="server" Width="150px"></asp:TextBox>
            ps:若為測試請填test<br />
            國家:
            <asp:TextBox ID="Country" type="text" runat="server" Width="150px"></asp:TextBox><br />
            品牌:
            <asp:TextBox ID="Brand" type="text" runat="server" Width="150px"></asp:TextBox><br />
            濃度:
            <asp:TextBox ID="abv" type="text" runat="server" Width="150px"></asp:TextBox>
            %<br />
            容量:
            <asp:TextBox ID="Capacity" type="text" runat="server" Width="150px"></asp:TextBox>
            ML<br />
            風味:
            <asp:TextBox ID="Taste" type="text" runat="server" Width="800px"></asp:TextBox><br />
            成份:
            <asp:TextBox ID="Ingredient" type="text" runat="server" Width="800px"></asp:TextBox><br />
            註解:
            <asp:TextBox ID="PS" type="text" runat="server" Width="800px"></asp:TextBox><br />
            圖片:
            <asp:TextBox ID="imagePath" type="text" runat="server" Width="800px"></asp:TextBox>
            <asp:Label ID="lbl_image" type="text" runat="server">ex:/ProductImage/testimage.jfif ; ps:請確認圖檔在LiquorApp/ProductImage內</asp:Label><br />
            <asp:Button ID="btn_Add" runat="server" Text="新增商品" OnClick="OnAddClick" Width="100px" CssClass="button" />
        </div>
        <h2>移除商品</h2>
        <div class="remove">
            <asp:DropDownList ID="ddl_DeleteItem" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name" AppendDataBoundItems="True">
                <asp:ListItem Selected="True" Value="None">None</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConn %>" SelectCommand="SELECT [Name] FROM [db_table_product] ORDER BY [productID] DESC"></asp:SqlDataSource>
            <asp:Label ID="Label2" runat="server" Width="25px"></asp:Label>
            <asp:Button ID="btn_Delete" runat="server" Text="刪除商品" OnClick="OnDeleteClick" Width="100px" />
        </div>
    </form>
</body>
</html>
