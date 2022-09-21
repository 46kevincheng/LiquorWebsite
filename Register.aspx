<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LiquorApp.Register" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void OnLoginClick(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void OnSubmitClick(object sender, EventArgs e)
    {
        //string connectionString = @"Data Source=LAPTOP-27BDJTVB;Initial Catalog=LiquorApp;Integrated Security=True";
        string connectionString = ConfigurationManager.ConnectionStrings["DBConn"].ToString();
        SqlConnection cnn = new SqlConnection(connectionString);
        cnn.Open();
        // 檢查email是否已存在
        String str = "SELECT COUNT(*) FROM db_table_account WHERE email='" + tb_email.Text.Trim() + "' ";
        SqlCommand sqlCmd = new SqlCommand(str, cnn);
        int count = 0;
        count = Convert.ToInt32(sqlCmd.ExecuteScalar());

        if (tb_email.Text == "" || tb_name.Text == "" || tb_phone.Text == "" || tb_password.Text == "" || tb_address.Text == "") // 檢查是否有空值
        {
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('未填寫所有資料!');window.history.back();<" + "/script>");
        }
        else if (count > 0) // 檢查email是否已存在
        {
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('email已存在!');window.history.back();<" + "/script>");
        }
        else if ((tb_password.Text != tb_confirmPw.Text))   // 確認密碼正確
        {
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('請確認密碼是否正確!');window.history.back();<" + "/script>");
        }
        else if (cb_Over18.Checked != true) // 檢查是否已成年
        {
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('未成年請勿註冊!');window.history.back();<" + "/script>");
        }
        else // 註冊成功，插入user資料到資料庫
        {
            // get the number of accounts in database
            String ss = "SELECT MAX(id) FROM db_table_account ";
            SqlCommand countCmd = new SqlCommand(ss, cnn);
            int maxID = 0;
            maxID = Convert.ToInt32(countCmd.ExecuteScalar());
            countCmd.Dispose();
            // give new account's id
            maxID++;
            Session["userID"] = maxID;
            Session["userName"] = tb_name.Text.Trim();
            SqlDataAdapter adapter = new SqlDataAdapter();
            String sql = "";
            sql = "INSERT INTO db_table_account(name,email,password,phone,id,admin,address) VALUES('" + tb_name.Text.Trim() + "' , " +
                                                                                  "'" + tb_email.Text.Trim() + "' , " +
                                                                                  "'" + tb_password.Text.Trim() + "' , " +
                                                                                  "'" + tb_phone.Text.Trim() + "' , " +
                                                                                  "'" + maxID + "' , " +
                                                                                  "'0' , " +    // if user is admin, 手動在資料庫將admin值改成1
                                                                                  "'" + tb_address.Text.Trim() + "' )";

            adapter.InsertCommand = new SqlCommand(sql, cnn);
            adapter.InsertCommand.ExecuteNonQuery();
            adapter.Dispose();
            sqlCmd.Dispose();
            cnn.Close();
            Response.Write("<script>alert('註冊成功!');<" + "/script>");
            Response.AppendHeader("Refresh", "0;url=Home.aspx");
        }//end else

    }// end OnSubmitClick
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/all.min.css">
    <link rel="stylesheet" href="assets/css/font.css">
    <link rel="stylesheet" href="assets/css/swiper.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <style>
        h1 {
            display: block;
            background: rgba(0, 128, 0, 0.1);
            font-weight: bold;
            font-style: italic;
        }

        .loginheader {
            padding-top: 25px;
            padding-bottom: 25px;
            font-size: 40px;
            text-align: center;
        }

        .btn {
            display: inline;
            position: relative;
            top: 50px;
            left: 800px;
            width: 500px;
        }

        span {
            font-size: 20px;
        }

        .btnclass {
            text-align: center;
            width: 100px;
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
    <form id="form1" runat="server">
        <div class="btn">
            <span>已經有帳號? </span>
            <asp:Button ID="btn_Login" runat="server" Text="登入" OnClick="OnLoginClick" CssClass="btnclass" />
        </div>
        <div class="pa-contact spacer-top">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="pa-contact-form">
                            <h2 class="loginheader">註冊 </h2>
                            <div>
                                請填寫所有資料，謝謝!
                                <br />
                                <br />
                            </div>
                            <div>
                                <span>名字: </span>
                                <asp:TextBox ID="tb_name" type="text" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>信箱: </span>
                                <asp:TextBox ID="tb_email" type="text" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>密碼: </span>
                                <asp:TextBox ID="tb_password" type="password" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>確認密碼: </span>
                                <asp:TextBox ID="tb_confirmPw" type="password" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>連絡電話: </span>
                                <asp:TextBox ID="tb_phone" type="text" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <span>取貨地址: </span>
                                <asp:TextBox ID="tb_address" type="text" runat="server"></asp:TextBox>
                            </div>
                            <div>
                                <asp:CheckBox ID="cb_Over18" runat="server" Text="是否已滿18歲，如未滿請勿註冊，如有請在上方框框中打勾" />
                            </div>
                            <div>
                                <asp:Button ID="Button1" runat="server" Text="註冊" OnClick="OnSubmitClick" CssClass="btnclass" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
