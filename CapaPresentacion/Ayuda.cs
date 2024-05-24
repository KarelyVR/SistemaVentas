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
        
        public Ayuda()
        {
            InitializeComponent();
            customizeDesing();
        }
        private void customizeDesing()
        {
            PnlTextP1.Visible = false;
            PnlTextP2.Visible = false;
            PnlTextP3.Visible = false;
            PnlTextP4.Visible = false;
            PnlTextP5.Visible = false;
            PnlTextP6.Visible = false;
            PnlTextP7.Visible = false;
            PnlTextP8.Visible = false;
            PnlTextP9.Visible = false;
            PnlTextP10.Visible = false;
            PnlTextP11.Visible = false;
            PnlTextP12.Visible = false;
            PnlTextP13.Visible = false;
            PnlTextP14.Visible = false;
            PnlTextP15.Visible = false;
            PnlTextP16.Visible = false;

        }

        private void hideSubMenu()
        {
            if (PnlTextP1.Visible == true)
                PnlTextP1.Visible = false;
            if (PnlTextP2.Visible == true)
                PnlTextP2.Visible = false;
            if (PnlTextP3.Visible == true)
                PnlTextP3.Visible = false;
            if (PnlTextP4.Visible == true)
                PnlTextP4.Visible = false;
            if (PnlTextP5.Visible == true)
                PnlTextP5.Visible = false;
            if (PnlTextP6.Visible == true)
                PnlTextP6.Visible = false;
            if (PnlTextP7.Visible == true)
                PnlTextP7.Visible = false;
            if (PnlTextP8.Visible == true)
                PnlTextP8.Visible = false;
            if (PnlTextP9.Visible == true)
                PnlTextP9.Visible = false;
            if (PnlTextP10.Visible == true)
                PnlTextP10.Visible = false;
            if (PnlTextP11.Visible == true)
                PnlTextP11.Visible = false;
            if (PnlTextP12.Visible == true)
                PnlTextP12.Visible = false;
            if (PnlTextP13.Visible == true)
                PnlTextP13.Visible = false;
            if (PnlTextP14.Visible == true)
                PnlTextP14.Visible = false;
            if (PnlTextP15.Visible == true)
                PnlTextP15.Visible = false;
            if (PnlTextP16.Visible == true)
                PnlTextP16.Visible = false;
        }
        private void showSubMenu(Panel subMenu)
        {
            if (subMenu.Visible == false)
            {
                hideSubMenu();
                subMenu.Visible = true;
            }
            else
                subMenu.Visible = false;
        }
         
        private void Ayuda_Load(object sender, EventArgs e)
        {

        }

        private void BtnP1_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP1);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP2_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP2);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP3_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP3);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP4_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP4);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP5_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP5);
        }

        private void button5_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP6_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP6);
        }

        private void button6_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP7_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP7);
        }

        private void button7_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP8_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP8);
        }

        private void button8_Click(object sender, EventArgs e)
        {
            hideSubMenu();

        }

        private void BtnP9_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP9);
        }

        private void button9_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP10_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP10);
        }

        private void button10_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP11_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP11);
        }

        private void button11_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP12_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP12);
        }

        private void button12_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP13_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP13);
        }

        private void button13_Click_1(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP14_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP14);
        }

        private void button14_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP15_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP15);
        }

        private void button15_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }

        private void BtnP16_Click(object sender, EventArgs e)
        {
            showSubMenu(PnlTextP16);
        }

        private void button16_Click(object sender, EventArgs e)
        {
            hideSubMenu();
        }
    }
}
