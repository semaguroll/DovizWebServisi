using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DovizWebServisi.Connection
{
    public class SqlConnect
    {
        public SqlConnection Connection()
        {
            SqlConnection sql = new SqlConnection("Data Source=.;Initial Catalog=DovizKur;Integrated Security=True;");
            //SqlConnection sql = new SqlConnection("Data Source = 91.93.1.160; Network Library = DBMSSOCN; Initial Catalog = semgu; User ID = semgu; Password = SemaGurol*1879; Integrated Security=True;");
            sql.Open();
            return sql;
        }
    }
}