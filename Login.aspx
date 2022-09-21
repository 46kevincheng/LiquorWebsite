<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LiquorApp.Login" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">
    // ctrl+k + ctrl+d  自動排版
    // ctrl+k + ctrl+c  選取範圍註解
    // ctrl+k + ctrl+u  選取範圍取消註解
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["iLiquorName"] = "";
            Session["iPriceLow"] = "0";
            Session["iPriceHigh"] = "100000";
            Session["iPercentLow"] = "0";
            Session["iPercentHigh"] = "100";
            Session["iType"] = "";
            Session["iBrand"] = "";
            Session["iCountry"] = "";
            Session["iTaste"] = "";
        }
    }

    protected void OnSubmitClick(object sender, EventArgs e)
    {
        // 建立 sql server 連線
        //string connectionString = @"Data Source=LAPTOP-27BDJTVB;Initial Catalog=LiquorApp;Integrated Security=True";
        string connectionString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection cnn = new SqlConnection(connectionString);
        cnn.Open();
        // 傳 sql 命令取得資料
        String str = "SELECT COUNT(*) FROM db_table_account WHERE email='" + tb_email.Text.Trim() + "' ";
        SqlCommand sqlCmd = new SqlCommand(str, cnn);
        int count = 0;
        count = Convert.ToInt32(sqlCmd.ExecuteScalar());

        if (tb_email.Text == "" || tb_password.Text == "") // 檢查是否有空值
        {
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('email與密碼均須填寫!');window.history.back();<" + "/script>");
        }
        else if (count < 1) // 檢查email不存在
        {
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('此email尚未註冊!');window.history.back();<" + "/script>");
        }
        else // 輸入email有註冊
        {
            sqlCmd.Dispose();
            String sqlstr = "SELECT COUNT(*) FROM db_table_account WHERE email = '" + tb_email.Text.Trim() + "' " +
                            " AND password = '" + tb_password.Text.Trim() + "'";
            SqlCommand checkCmd = new SqlCommand(sqlstr, cnn);
            int tmp = 0;
            tmp = Convert.ToInt32(checkCmd.ExecuteScalar());
            if (tmp != 1)
            { // 檢查email 與 password 是否match
                checkCmd.Dispose();
                cnn.Close();
                Response.Write("<script>alert('email或密碼輸入錯誤!');window.history.back();<" + "/script>");
            }
            else // 登入成功
            {
                checkCmd.Dispose();
                // get user's id
                String ss = "SELECT id FROM db_table_account WHERE email = '" + tb_email.Text.Trim() + "' " +
                            " AND password = '" + tb_password.Text.Trim() + "'";
                SqlCommand countCmd = new SqlCommand(ss, cnn);
                int userID = 0;
                userID = Convert.ToInt32(countCmd.ExecuteScalar());
                Session["userID"] = userID;
                // get user's name
                ss = "SELECT name FROM db_table_account WHERE email = '" + tb_email.Text.Trim() + "' " +
                            " AND password = '" + tb_password.Text.Trim() + "'";
                countCmd = new SqlCommand(ss, cnn);
                Session["userName"] = countCmd.ExecuteScalar().ToString();
                countCmd.Dispose();
                cnn.Close();
                Response.Redirect("Home.aspx");
            }//end else
        }//end else
    }// end function OnSubmitClick

    protected void OnRegisterClick(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx");
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登入</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/font.css" />
    <link rel="stylesheet" href="assets/css/swiper.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <style>
        .loginheader {
            padding-top: 25px;
            padding-bottom: 25px;
            font-size: 40px;
            text-align: center;
        }

        h1 {
            display:block;
            background: rgba(0, 128, 0, 0.1);
            font-weight: bold;
            font-style: italic;
        }
    </style>
</head>
<body>
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

    <div class="pa-contact spacer-top">
        <div class="container">
            <div class="row">
                <div class="col-xl-9">
                    <div class="pa-contact-form">
                        <form id="form1" runat="server">
                            <h2 class="loginheader">登入 </h2>
                            <div>
                                <span>Email: </span>
                                <asp:TextBox ID="tb_email" type="text" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>Password: </span>
                                <asp:TextBox ID="tb_password" type="password" runat="server"></asp:TextBox>
                            </div>

                            <div>
                                <asp:Button ID="btn_Submit" runat="server" Text="登入" OnClick="OnSubmitClick" />
                            </div>
                            <div>
                                <br />
                                <span>還沒有註冊? </span>
                                <asp:Button ID="btn_Register" runat="server" Text="註冊" OnClick="OnRegisterClick" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/SmoothScroll.min.js"></script>
    <script src="assets/js/swiper.min.js"></script>
    <script src="assets/js/custom.js"></script>
</body>
</html>
