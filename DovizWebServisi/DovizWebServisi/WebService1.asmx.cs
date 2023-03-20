using DovizWebServisi.Connection;
using DovizWebServisi.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;

namespace DovizWebServisi
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        SqlConnect conn = new SqlConnect();

        [WebMethod]
        public void GetData()
        {

            while (true)
            {

                SqlCommand cmd = new SqlCommand("EXEC DovizKurbilgisi", conn.Connection());

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "DovizKurbilgisi";
                cmd.ExecuteNonQuery();
                Thread.Sleep(60000);
            }

        }

    }
}
