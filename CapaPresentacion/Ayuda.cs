using CapaPresentacion.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaPresentacion
{
    
    public partial class Ayuda : Form
    {
        //private bool isCollapsed;
        private bool isCollapsedPanel1;
        private bool isCollapsedPanel3;
        private bool isCollapsedPanel4;
        private bool isCollapsedPanel5;
        private bool isCollapsedPanel6;
        private bool isCollapsedPanel7;
        public Ayuda()
        {
            InitializeComponent();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (isCollapsedPanel1)
            {
                button1.Image = Resources.Collapse_Arrow_20px;
                panel1.Height += 10;
                if (panel1.Height >= panel1.MaximumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel1 = false;
                }
            }
            else
            {
                button1.Image = Resources.Expand_Arrow_20px;
                panel1.Height -= 10;
                if (panel1.Height <= panel1.MinimumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel1 = true;
                }
            }
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            timer1.Start();
        }

        private void Ayuda_Load(object sender, EventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            if (isCollapsedPanel3)
            {
                button4.Image = Resources.Collapse_Arrow_20px;
                panel3.Height += 10;
                if (panel3.Height >= panel3.MaximumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel3 = false;
                }
            }
            else
            {
                button4.Image = Resources.Expand_Arrow_20px;
                panel3.Height -= 10;
                if (panel3.Height <= panel3.MinimumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel3 = true;
                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            timer2.Start();
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            if (isCollapsedPanel4)
            {
                button6.Image = Resources.Collapse_Arrow_20px;
                panel4.Height += 10;
                if (panel4.Height >= panel4.MaximumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel4 = false;
                }
            }
            else
            {
                button6.Image = Resources.Expand_Arrow_20px;
                panel4.Height -= 10;
                if (panel4.Height <= panel4.MinimumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel4 = true;
                }
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            timer3.Start();
        }

        private void timer4_Tick(object sender, EventArgs e)
        {
            if (isCollapsedPanel5)
            {
                button8.Image = Resources.Collapse_Arrow_20px;
                panel5.Height += 10;
                if (panel5.Height >= panel5.MaximumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel5 = false;
                }
            }
            else
            {
                button8.Image = Resources.Expand_Arrow_20px;
                panel5.Height -= 10;
                if (panel5.Height <= panel5.MinimumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel5 = true;
                }
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            timer4.Start();
        }

        private void timer5_Tick(object sender, EventArgs e)
        {
            if (isCollapsedPanel6)
            {
                button10.Image = Resources.Collapse_Arrow_20px;
                panel6.Height += 10;
                if (panel6.Height >= panel6.MaximumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel6 = false;
                }
            }
            else
            {
                button10.Image = Resources.Expand_Arrow_20px;
                panel6.Height -= 10;
                if (panel6.Height <= panel6.MinimumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel6 = true;
                }
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            timer5.Start();
        }

        private void timer6_Tick(object sender, EventArgs e)
        {
            if (isCollapsedPanel7)
            {
                button12.Image = Resources.Collapse_Arrow_20px;
                panel7.Height += 10;
                if (panel7.Height >= panel7.MaximumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel7 = false;
                }
            }
            else
            {
                button12.Image = Resources.Expand_Arrow_20px;
                panel7.Height -= 10;
                if (panel7.Height <= panel7.MinimumSize.Height)
                {
                    timer1.Stop();
                    isCollapsedPanel7 = true;
                }
            }
        }

        private void button12_Click(object sender, EventArgs e)
        {
            timer6.Start();
        }
    }
}
