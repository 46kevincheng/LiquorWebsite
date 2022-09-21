<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="LiquorApp.Home" %>

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
            String str = "SELECT admin FROM db_table_account WHERE id = '" + Session["userID"] + "' ";
            SqlCommand sqlCmd = new SqlCommand(str, cnn);
            int isAdmin = 0;    // 0 = not admin , 1 = is admin
            isAdmin = Convert.ToInt32(sqlCmd.ExecuteScalar());
            sqlCmd.Dispose();
            cnn.Close();

            if (isAdmin == 1) // user is admin
            {
                btn_AddProduct.Visible = true;
                btn_CheckOrder.Visible = true;
                header.Visible = true;
            }
            else
            {
                btn_AddProduct.Visible = false;
                btn_CheckOrder.Visible = false;
                header.Visible = false;
            }
        }
    }
    protected void OnAddProductClick(object sender, EventArgs e)
    {
        Response.Redirect("AddProduct.aspx");
    }
    protected void OnOrderClick(object sender, EventArgs e)
    {
        Response.Redirect("CheckOrder.aspx");
    }
    protected void OnQueryClick(object sender, EventArgs e)
    {
        Response.Redirect("Query.aspx");
    }
    protected void OnProductClick(object sender, EventArgs e)
    {
        Response.Redirect("Product.aspx");
    }
    protected void OnAccountClick(object sender, EventArgs e)
    {
        Response.Redirect("Account.aspx");
    }
    protected void OnCartClick(object sender, EventArgs e)
    {
        Response.Redirect("Cart.aspx");
    }
    protected void OnLogoutClick(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>首頁</title>
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

        .homebtn {
            text-align: center;
        }

        .admin {
            display: block;
            text-align: center;
            font-weight: bold;
            font-style: italic;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="admin">
        <asp:Label ID="header" runat="server" Visible="false">Hello 管理員!</asp:Label>
    </div>
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

    <div class="pa-banner-three">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-5">
                    <div class="pa-banner-three-text">
                        <div class="pa-banner-search">
                            <form id="form1" runat="server">
                                <ul>
                                    <li>
                                        <asp:Button ID="btn_Account" runat="server" Text="My帳戶" OnClick="OnAccountClick" Width="50px" CssClass="homebtn" />

                                        <asp:Button ID="btn_Query" runat="server" Text="查詢商品" OnClick="OnQueryClick" Width="50px" CssClass="homebtn" />

                                        <asp:Button ID="btn_Product" runat="server" Text="商品" OnClick="OnProductClick" Width="50px" CssClass="homebtn" />

                                        <asp:Button ID="btn_Cart" runat="server" Text="My購物車" OnClick="OnCartClick" Width="50px" CssClass="homebtn" />

                                        <asp:Button ID="btn_CheckOrder" runat="server" Text="查詢訂單" OnClick="OnOrderClick" Width="50px" Visible="False" CssClass="homebtn" ForeColor="#0099FF" />

                                        <asp:Button ID="btn_AddProduct" runat="server" Text="新增/移除商品" OnClick="OnAddProductClick" Width="50px" Visible="False" CssClass="homebtn" ForeColor="#0099FF" />

                                        <asp:Button ID="btn_Logout" runat="server" Text="登出" OnClick="OnLogoutClick" Width="50px" CssClass="homebtn" /></li>
                                </ul>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pa-banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-6">
                    <div class="pa-banner-text">
                        <h4 class="pa-banner-category">緣起</h4>
                        <h2>讓嘴饞的顧客都可以品嘗到自己喜愛的選擇	</h2>
                        <p>這是一個線上酒品販售系統，每一個產品我們都親自品嘗並撰寫評論</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pa-medicine spacer-top spacer-bottom">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="pa-medicine-box">
                        <img src="assets/images/top1.jpg" alt="image" class="img-fluid" />
                        <h2><a href="#">啤酒</a></h2>
                        <a href="#">beer</a>
                        <p>世界知名啤酒 </p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="pa-medicine-box">
                        <img src="assets/images/top2.jpg" alt="image" class="img-fluid" />
                        <h2><a href="#">威士忌</a></h2>
                        <a href="#">Whiskey</a>
                        <p>高端享受</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="pa-medicine-box">
                        <img src="assets/images/top3.jpg" alt="image" class="img-fluid" />
                        <h2><a href="#">調酒</a></h2>
                        <a href="#">Bartending</a>
                        <p>現點現調 </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pa-why spacer-top spacer-bottom">
        <div class="container">
            <div class="pa-heading">
                <img src="assets/images/herbal.svg" alt="image" class="img-fluid" />
                <h1>why pure Ayurveda</h1>
                <h5>選找最適合你的酒品</h5>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-6 pr-0">
                    <div class="pa-why-ul pa-why-left">
                        <ul>
                            <li>擁有代理商證書</li>
                            <li>絕對不混假酒</li>
                            <li>專業調酒人員</li>
                            <li>簡單操作的購買網站</li>

                        </ul>
                    </div>
                </div>
                <div class="col-md-4 p-0">
                    <div class="pa-why-img">
                        <img src="assets/images/1.png" alt="image" class="img-fluid">
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 pl-0">
                    <div class="pa-why-ul pa-why-right">
                        <ul>
                            <li>清楚的價格標示</li>
                            <li>最完整風味介紹</li>
                            <li>易上手的查詢功能</li>
                            <li>免除晝短苦夜長的煩惱</li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pa-product spacer-top">
        <div class="container">
            <div class="pa-heading">
                <img src="assets/images/herbal.svg" alt="image" class="img-fluid" />
                <h1>top products</h1>

            </div>
            <div class="row">
                <div class="col-lg-4 col-sm-6">
                    <div class="pa-product-box">
                        <div class="pa-product-img">
                            <img src="assets/images/product1.png" alt="image" class="img-fluid" />
                        </div>
                        <div class="pa-product-content">
                            <h4><a href="product-single.html">惠比壽啤酒</a></h4>
                            <p class="pa-product-rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </p>

                        </div>
                        <div class="pa-product-cart">
                            <ul>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 469.333 469.333">
                                            <g>
                                                <path d="M434.979,42.667H85.333c-1.053,0-2.014,0.396-3.001,0.693l-8.594-28.241C71.005,6.138,62.721,0,53.333,0H10.667
												C4.776,0,0,4.776,0,10.667V32c0,5.891,4.776,10.667,10.667,10.667h26.865l66.646,219.01l-24.891,29.039
												c-9.838,11.477-14.268,27.291-9.74,41.713c5.791,18.445,22.07,30.237,40.839,30.237H416c5.891,0,10.667-4.776,10.667-10.667
												v-21.333c0-5.891-4.776-10.667-10.667-10.667H110.385l33.813-39.448c0.85-0.992,1.475-2.112,2.12-3.219h206.703
												c16.533,0,31.578-9.548,38.618-24.507l74.434-158.17c2.135-4.552,3.26-9.604,3.26-14.615v-3.021
												C469.333,58.048,453.952,42.667,434.979,42.667z" />
                                                <circle cx="128" cy="426.667" r="42.667" />
                                                <circle cx="384" cy="426.667" r="42.667" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <g>
                                                <path d="M376,30c-27.783,0-53.255,8.804-75.707,26.168c-21.525,16.647-35.856,37.85-44.293,53.268
												c-8.437-15.419-22.768-36.621-44.293-53.268C189.255,38.804,163.783,30,136,30C58.468,30,0,93.417,0,177.514
												c0,90.854,72.943,153.015,183.369,247.118c18.752,15.981,40.007,34.095,62.099,53.414C248.38,480.596,252.12,482,256,482
												s7.62-1.404,10.532-3.953c22.094-19.322,43.348-37.435,62.111-53.425C439.057,330.529,512,268.368,512,177.514
												C512,93.417,453.532,30,376,30z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 461.312 461.312">
                                            <g>
                                                <path d="M230.656,156.416c-40.96,0-74.24,33.28-74.24,74.24s33.28,74.24,74.24,74.24s74.24-33.28,74.24-74.24
												S271.616,156.416,230.656,156.416z M225.024,208.64c-9.216,0-16.896,7.68-16.896,16.896h-24.576
												c0.512-23.04,18.944-41.472,41.472-41.472V208.64z" />
                                            </g>
                                            <g>
                                                <path d="M455.936,215.296c-25.088-31.232-114.688-133.12-225.28-133.12S30.464,184.064,5.376,215.296
												c-7.168,8.704-7.168,21.504,0,30.72c25.088,31.232,114.688,133.12,225.28,133.12s200.192-101.888,225.28-133.12
												C463.104,237.312,463.104,224.512,455.936,215.296z M230.656,338.176c-59.392,0-107.52-48.128-107.52-107.52
												s48.128-107.52,107.52-107.52s107.52,48.128,107.52,107.52S290.048,338.176,230.656,338.176z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="pa-product-box">
                        <div class="pa-product-img">
                            <img src="assets/images/product2.png" alt="image" class="img-fluid" />
                        </div>
                        <div class="pa-product-content">
                            <h4><a href="product-single.html">朝日啤酒</a></h4>
                            <p class="pa-product-rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </p>

                        </div>
                        <div class="pa-product-cart">
                            <ul>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 469.333 469.333">
                                            <g>
                                                <path d="M434.979,42.667H85.333c-1.053,0-2.014,0.396-3.001,0.693l-8.594-28.241C71.005,6.138,62.721,0,53.333,0H10.667
												C4.776,0,0,4.776,0,10.667V32c0,5.891,4.776,10.667,10.667,10.667h26.865l66.646,219.01l-24.891,29.039
												c-9.838,11.477-14.268,27.291-9.74,41.713c5.791,18.445,22.07,30.237,40.839,30.237H416c5.891,0,10.667-4.776,10.667-10.667
												v-21.333c0-5.891-4.776-10.667-10.667-10.667H110.385l33.813-39.448c0.85-0.992,1.475-2.112,2.12-3.219h206.703
												c16.533,0,31.578-9.548,38.618-24.507l74.434-158.17c2.135-4.552,3.26-9.604,3.26-14.615v-3.021
												C469.333,58.048,453.952,42.667,434.979,42.667z" />
                                                <circle cx="128" cy="426.667" r="42.667" />
                                                <circle cx="384" cy="426.667" r="42.667" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <g>
                                                <path d="M376,30c-27.783,0-53.255,8.804-75.707,26.168c-21.525,16.647-35.856,37.85-44.293,53.268
												c-8.437-15.419-22.768-36.621-44.293-53.268C189.255,38.804,163.783,30,136,30C58.468,30,0,93.417,0,177.514
												c0,90.854,72.943,153.015,183.369,247.118c18.752,15.981,40.007,34.095,62.099,53.414C248.38,480.596,252.12,482,256,482
												s7.62-1.404,10.532-3.953c22.094-19.322,43.348-37.435,62.111-53.425C439.057,330.529,512,268.368,512,177.514
												C512,93.417,453.532,30,376,30z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 461.312 461.312">
                                            <g>
                                                <path d="M230.656,156.416c-40.96,0-74.24,33.28-74.24,74.24s33.28,74.24,74.24,74.24s74.24-33.28,74.24-74.24
												S271.616,156.416,230.656,156.416z M225.024,208.64c-9.216,0-16.896,7.68-16.896,16.896h-24.576
												c0.512-23.04,18.944-41.472,41.472-41.472V208.64z" />
                                            </g>
                                            <g>
                                                <path d="M455.936,215.296c-25.088-31.232-114.688-133.12-225.28-133.12S30.464,184.064,5.376,215.296
												c-7.168,8.704-7.168,21.504,0,30.72c25.088,31.232,114.688,133.12,225.28,133.12s200.192-101.888,225.28-133.12
												C463.104,237.312,463.104,224.512,455.936,215.296z M230.656,338.176c-59.392,0-107.52-48.128-107.52-107.52
												s48.128-107.52,107.52-107.52s107.52,48.128,107.52,107.52S290.048,338.176,230.656,338.176z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="pa-product-box">
                        <div class="pa-product-img">
                            <img src="assets/images/product3.png" alt="image" class="img-fluid" />
                        </div>
                        <div class="pa-product-content">
                            <h4><a href="product-single.html">熱帶枝葉</a></h4>
                            <p class="pa-product-rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </p>

                        </div>
                        <div class="pa-product-cart">
                            <ul>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 469.333 469.333">
                                            <g>
                                                <path d="M434.979,42.667H85.333c-1.053,0-2.014,0.396-3.001,0.693l-8.594-28.241C71.005,6.138,62.721,0,53.333,0H10.667
												C4.776,0,0,4.776,0,10.667V32c0,5.891,4.776,10.667,10.667,10.667h26.865l66.646,219.01l-24.891,29.039
												c-9.838,11.477-14.268,27.291-9.74,41.713c5.791,18.445,22.07,30.237,40.839,30.237H416c5.891,0,10.667-4.776,10.667-10.667
												v-21.333c0-5.891-4.776-10.667-10.667-10.667H110.385l33.813-39.448c0.85-0.992,1.475-2.112,2.12-3.219h206.703
												c16.533,0,31.578-9.548,38.618-24.507l74.434-158.17c2.135-4.552,3.26-9.604,3.26-14.615v-3.021
												C469.333,58.048,453.952,42.667,434.979,42.667z" />
                                                <circle cx="128" cy="426.667" r="42.667" />
                                                <circle cx="384" cy="426.667" r="42.667" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <g>
                                                <path d="M376,30c-27.783,0-53.255,8.804-75.707,26.168c-21.525,16.647-35.856,37.85-44.293,53.268
												c-8.437-15.419-22.768-36.621-44.293-53.268C189.255,38.804,163.783,30,136,30C58.468,30,0,93.417,0,177.514
												c0,90.854,72.943,153.015,183.369,247.118c18.752,15.981,40.007,34.095,62.099,53.414C248.38,480.596,252.12,482,256,482
												s7.62-1.404,10.532-3.953c22.094-19.322,43.348-37.435,62.111-53.425C439.057,330.529,512,268.368,512,177.514
												C512,93.417,453.532,30,376,30z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 461.312 461.312">
                                            <g>
                                                <path d="M230.656,156.416c-40.96,0-74.24,33.28-74.24,74.24s33.28,74.24,74.24,74.24s74.24-33.28,74.24-74.24
												S271.616,156.416,230.656,156.416z M225.024,208.64c-9.216,0-16.896,7.68-16.896,16.896h-24.576
												c0.512-23.04,18.944-41.472,41.472-41.472V208.64z" />
                                            </g>
                                            <g>
                                                <path d="M455.936,215.296c-25.088-31.232-114.688-133.12-225.28-133.12S30.464,184.064,5.376,215.296
												c-7.168,8.704-7.168,21.504,0,30.72c25.088,31.232,114.688,133.12,225.28,133.12s200.192-101.888,225.28-133.12
												C463.104,237.312,463.104,224.512,455.936,215.296z M230.656,338.176c-59.392,0-107.52-48.128-107.52-107.52
												s48.128-107.52,107.52-107.52s107.52,48.128,107.52,107.52S290.048,338.176,230.656,338.176z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="pa-product-box">
                        <div class="pa-product-img">
                            <img src="assets/images/product4.png" alt="image" class="img-fluid" />
                        </div>
                        <div class="pa-product-content">
                            <h4><a href="product-single.html">紫羅蘭情調</a></h4>
                            <p class="pa-product-rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </p>

                        </div>
                        <div class="pa-product-cart">
                            <ul>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 469.333 469.333">
                                            <g>
                                                <path d="M434.979,42.667H85.333c-1.053,0-2.014,0.396-3.001,0.693l-8.594-28.241C71.005,6.138,62.721,0,53.333,0H10.667
												C4.776,0,0,4.776,0,10.667V32c0,5.891,4.776,10.667,10.667,10.667h26.865l66.646,219.01l-24.891,29.039
												c-9.838,11.477-14.268,27.291-9.74,41.713c5.791,18.445,22.07,30.237,40.839,30.237H416c5.891,0,10.667-4.776,10.667-10.667
												v-21.333c0-5.891-4.776-10.667-10.667-10.667H110.385l33.813-39.448c0.85-0.992,1.475-2.112,2.12-3.219h206.703
												c16.533,0,31.578-9.548,38.618-24.507l74.434-158.17c2.135-4.552,3.26-9.604,3.26-14.615v-3.021
												C469.333,58.048,453.952,42.667,434.979,42.667z" />
                                                <circle cx="128" cy="426.667" r="42.667" />
                                                <circle cx="384" cy="426.667" r="42.667" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <g>
                                                <path d="M376,30c-27.783,0-53.255,8.804-75.707,26.168c-21.525,16.647-35.856,37.85-44.293,53.268
												c-8.437-15.419-22.768-36.621-44.293-53.268C189.255,38.804,163.783,30,136,30C58.468,30,0,93.417,0,177.514
												c0,90.854,72.943,153.015,183.369,247.118c18.752,15.981,40.007,34.095,62.099,53.414C248.38,480.596,252.12,482,256,482
												s7.62-1.404,10.532-3.953c22.094-19.322,43.348-37.435,62.111-53.425C439.057,330.529,512,268.368,512,177.514
												C512,93.417,453.532,30,376,30z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 461.312 461.312">
                                            <g>
                                                <path d="M230.656,156.416c-40.96,0-74.24,33.28-74.24,74.24s33.28,74.24,74.24,74.24s74.24-33.28,74.24-74.24
												S271.616,156.416,230.656,156.416z M225.024,208.64c-9.216,0-16.896,7.68-16.896,16.896h-24.576
												c0.512-23.04,18.944-41.472,41.472-41.472V208.64z" />
                                            </g>
                                            <g>
                                                <path d="M455.936,215.296c-25.088-31.232-114.688-133.12-225.28-133.12S30.464,184.064,5.376,215.296
												c-7.168,8.704-7.168,21.504,0,30.72c25.088,31.232,114.688,133.12,225.28,133.12s200.192-101.888,225.28-133.12
												C463.104,237.312,463.104,224.512,455.936,215.296z M230.656,338.176c-59.392,0-107.52-48.128-107.52-107.52
												s48.128-107.52,107.52-107.52s107.52,48.128,107.52,107.52S290.048,338.176,230.656,338.176z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="pa-product-box">
                        <div class="pa-product-img">
                            <img src="assets/images/product5.png" alt="image" class="img-fluid" />
                        </div>
                        <div class="pa-product-content">
                            <h4><a href="product-single.html">百富17年</a></h4>
                            <p class="pa-product-rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </p>

                        </div>
                        <div class="pa-product-cart">
                            <ul>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 469.333 469.333">
                                            <g>
                                                <path d="M434.979,42.667H85.333c-1.053,0-2.014,0.396-3.001,0.693l-8.594-28.241C71.005,6.138,62.721,0,53.333,0H10.667
												C4.776,0,0,4.776,0,10.667V32c0,5.891,4.776,10.667,10.667,10.667h26.865l66.646,219.01l-24.891,29.039
												c-9.838,11.477-14.268,27.291-9.74,41.713c5.791,18.445,22.07,30.237,40.839,30.237H416c5.891,0,10.667-4.776,10.667-10.667
												v-21.333c0-5.891-4.776-10.667-10.667-10.667H110.385l33.813-39.448c0.85-0.992,1.475-2.112,2.12-3.219h206.703
												c16.533,0,31.578-9.548,38.618-24.507l74.434-158.17c2.135-4.552,3.26-9.604,3.26-14.615v-3.021
												C469.333,58.048,453.952,42.667,434.979,42.667z" />
                                                <circle cx="128" cy="426.667" r="42.667" />
                                                <circle cx="384" cy="426.667" r="42.667" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <g>
                                                <path d="M376,30c-27.783,0-53.255,8.804-75.707,26.168c-21.525,16.647-35.856,37.85-44.293,53.268
												c-8.437-15.419-22.768-36.621-44.293-53.268C189.255,38.804,163.783,30,136,30C58.468,30,0,93.417,0,177.514
												c0,90.854,72.943,153.015,183.369,247.118c18.752,15.981,40.007,34.095,62.099,53.414C248.38,480.596,252.12,482,256,482
												s7.62-1.404,10.532-3.953c22.094-19.322,43.348-37.435,62.111-53.425C439.057,330.529,512,268.368,512,177.514
												C512,93.417,453.532,30,376,30z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 461.312 461.312">
                                            <g>
                                                <path d="M230.656,156.416c-40.96,0-74.24,33.28-74.24,74.24s33.28,74.24,74.24,74.24s74.24-33.28,74.24-74.24
												S271.616,156.416,230.656,156.416z M225.024,208.64c-9.216,0-16.896,7.68-16.896,16.896h-24.576
												c0.512-23.04,18.944-41.472,41.472-41.472V208.64z" />
                                            </g>
                                            <g>
                                                <path d="M455.936,215.296c-25.088-31.232-114.688-133.12-225.28-133.12S30.464,184.064,5.376,215.296
												c-7.168,8.704-7.168,21.504,0,30.72c25.088,31.232,114.688,133.12,225.28,133.12s200.192-101.888,225.28-133.12
												C463.104,237.312,463.104,224.512,455.936,215.296z M230.656,338.176c-59.392,0-107.52-48.128-107.52-107.52
												s48.128-107.52,107.52-107.52s107.52,48.128,107.52,107.52S290.048,338.176,230.656,338.176z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="pa-product-box">
                        <div class="pa-product-img">
                            <img src="assets/images/product6.png" alt="image" class="img-fluid" />
                        </div>
                        <div class="pa-product-content">
                            <h4><a href="product-single.html">響30年</a></h4>
                            <p class="pa-product-rating">
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                            </p>

                        </div>
                        <div class="pa-product-cart">
                            <ul>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 469.333 469.333">
                                            <g>
                                                <path d="M434.979,42.667H85.333c-1.053,0-2.014,0.396-3.001,0.693l-8.594-28.241C71.005,6.138,62.721,0,53.333,0H10.667
												C4.776,0,0,4.776,0,10.667V32c0,5.891,4.776,10.667,10.667,10.667h26.865l66.646,219.01l-24.891,29.039
												c-9.838,11.477-14.268,27.291-9.74,41.713c5.791,18.445,22.07,30.237,40.839,30.237H416c5.891,0,10.667-4.776,10.667-10.667
												v-21.333c0-5.891-4.776-10.667-10.667-10.667H110.385l33.813-39.448c0.85-0.992,1.475-2.112,2.12-3.219h206.703
												c16.533,0,31.578-9.548,38.618-24.507l74.434-158.17c2.135-4.552,3.26-9.604,3.26-14.615v-3.021
												C469.333,58.048,453.952,42.667,434.979,42.667z" />
                                                <circle cx="128" cy="426.667" r="42.667" />
                                                <circle cx="384" cy="426.667" r="42.667" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                            <g>
                                                <path d="M376,30c-27.783,0-53.255,8.804-75.707,26.168c-21.525,16.647-35.856,37.85-44.293,53.268
												c-8.437-15.419-22.768-36.621-44.293-53.268C189.255,38.804,163.783,30,136,30C58.468,30,0,93.417,0,177.514
												c0,90.854,72.943,153.015,183.369,247.118c18.752,15.981,40.007,34.095,62.099,53.414C248.38,480.596,252.12,482,256,482
												s7.62-1.404,10.532-3.953c22.094-19.322,43.348-37.435,62.111-53.425C439.057,330.529,512,268.368,512,177.514
												C512,93.417,453.532,30,376,30z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 461.312 461.312">
                                            <g>
                                                <path d="M230.656,156.416c-40.96,0-74.24,33.28-74.24,74.24s33.28,74.24,74.24,74.24s74.24-33.28,74.24-74.24
												S271.616,156.416,230.656,156.416z M225.024,208.64c-9.216,0-16.896,7.68-16.896,16.896h-24.576
												c0.512-23.04,18.944-41.472,41.472-41.472V208.64z" />
                                            </g>
                                            <g>
                                                <path d="M455.936,215.296c-25.088-31.232-114.688-133.12-225.28-133.12S30.464,184.064,5.376,215.296
												c-7.168,8.704-7.168,21.504,0,30.72c25.088,31.232,114.688,133.12,225.28,133.12s200.192-101.888,225.28-133.12
												C463.104,237.312,463.104,224.512,455.936,215.296z M230.656,338.176c-59.392,0-107.52-48.128-107.52-107.52
												s48.128-107.52,107.52-107.52s107.52,48.128,107.52,107.52S290.048,338.176,230.656,338.176z" />
                                            </g>
                                        </svg>
                                    </a>
                                </li>
                            </ul>
                        </div>
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

