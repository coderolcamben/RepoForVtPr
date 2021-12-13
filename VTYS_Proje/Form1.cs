using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VTYS_Proje
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; Database=dbFilm; user ID=postgres; password=dondoberk1234");
        private void BtnListle_Click(object sender, EventArgs e)
        {
            string query = "select * from film";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, connection);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
        }

        private void BtnEkle_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command = new NpgsqlCommand("insert into film (film_id,film_ad,film_butce,film_gelir,film_tarih,film_oy) values (@p1,@p2,@p3,@p4,@p5,@p6)",connection);
            command.Parameters.AddWithValue("@p1", int.Parse(TxtID.Text));
            command.Parameters.AddWithValue("@p2",TxtAd.Text);
            command.Parameters.AddWithValue("@p3", double.Parse(TxtButce.Text));
            command.Parameters.AddWithValue("@p4", double.Parse(TxtGelir.Text));
            command.Parameters.AddWithValue("@p5", dateTimePicker1.Value);
            command.Parameters.AddWithValue("@p6", double.Parse(TxtOy.Text));
            command.ExecuteNonQuery();
            connection.Close();

        }

        private void BtnSil_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command = new NpgsqlCommand("Delete from film where film_id=@p1", connection);
            command.Parameters.AddWithValue("@p1", int.Parse(TxtID.Text));
            command.ExecuteNonQuery();
            connection.Close();
        }

        private void BtnGuncelle_Click(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlCommand command = new NpgsqlCommand("update film set film_ad=@p1,film_butce=@p2,film_gelir=@p3,film_tarih=@p4,film_oy=@p5 where film_id=@p6", connection);
            command.Parameters.AddWithValue("@p1", TxtAd.Text);
            command.Parameters.AddWithValue("@p2", double.Parse(TxtButce.Text));
            command.Parameters.AddWithValue("@p3", double.Parse(TxtGelir.Text));
            command.Parameters.AddWithValue("@p4", dateTimePicker1.Value);
            command.Parameters.AddWithValue("@p5", double.Parse(TxtOy.Text));
            command.Parameters.AddWithValue("@p6", int.Parse(TxtID.Text));
            command.ExecuteNonQuery();
            connection.Close();

        }

        private void TxtAra_TextChanged(object sender, EventArgs e)
        {
            connection.Open();
            DataTable tb1 = new DataTable();
            NpgsqlDataAdapter ara = new NpgsqlDataAdapter("select * from film where film_ad like '%" + TxtAra.Text + "%'", connection);
            ara.Fill(tb1);
            dataGridView1.DataSource = tb1;
            connection.Close();
        }
    }
}
