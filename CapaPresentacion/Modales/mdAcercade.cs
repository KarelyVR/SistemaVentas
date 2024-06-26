﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace CapaPresentacion.Modales
{
    public partial class mdAcercade : Form
    {
        public mdAcercade()
        {
            InitializeComponent();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void btndescargar_Click(object sender, EventArgs e)
        {
            // Ruta del archivo PDF en tu computadora
            //string pdfPath = @"C:\Users\maryk\Desktop\PROY_INT2\Repositorio\SistemaVentas\CapaPresentacion\Resources\ManualDeUsuario.pdf";
            string pdfPath = Path.Combine(Directory.GetCurrentDirectory(),"Resources", "Manual_Usuario.pdf");
            // Verificar si el archivo existe
            if (System.IO.File.Exists(pdfPath))
            {
                // Configurar la descarga del archivo
                string nombreArchivo = System.IO.Path.GetFileName(pdfPath);

                // Configurar el diálogo de descarga
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.FileName = nombreArchivo;
                saveFileDialog.Filter = $"Archivos PDF (*.pdf)|*.pdf";
                saveFileDialog.Title = "Guardar archivo PDF";
                saveFileDialog.RestoreDirectory = true;

                // Mostrar el diálogo de descarga
                if (saveFileDialog.ShowDialog() == DialogResult.OK)
                {
                    // Obtener la ruta de destino seleccionada por el usuario
                    string rutaDestino = saveFileDialog.FileName;

                    try
                    {
                        // Copiar el archivo al destino seleccionado
                        System.IO.File.Copy(pdfPath, rutaDestino, true);

                        MessageBox.Show("Archivo descargado correctamente.", "Descarga exitosa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Ocurrió un error al descargar el archivo: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            else
            {
                MessageBox.Show("El archivo no existe.", "Archivo no encontrado", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
    }
}
