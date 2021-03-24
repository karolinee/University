namespace zad5
{
    partial class AddStudent
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button_addStudent_OK = new System.Windows.Forms.Button();
            this.text_name = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.text_birth = new System.Windows.Forms.TextBox();
            this.text_place = new System.Windows.Forms.TextBox();
            this.text_surname = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // button_addStudent_OK
            // 
            this.button_addStudent_OK.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.button_addStudent_OK.Location = new System.Drawing.Point(15, 119);
            this.button_addStudent_OK.Name = "button_addStudent_OK";
            this.button_addStudent_OK.Size = new System.Drawing.Size(273, 23);
            this.button_addStudent_OK.TabIndex = 0;
            this.button_addStudent_OK.Text = "Zatwierdź";
            this.button_addStudent_OK.UseVisualStyleBackColor = true;
            this.button_addStudent_OK.Click += new System.EventHandler(this.button_addStudent_OK_Click);
            // 
            // text_name
            // 
            this.text_name.Location = new System.Drawing.Point(130, 12);
            this.text_name.Name = "text_name";
            this.text_name.Size = new System.Drawing.Size(160, 20);
            this.text_name.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(95, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(29, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Imie:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(68, 41);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Nazwisko:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(42, 67);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(82, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Data urodzenia:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 93);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(112, 13);
            this.label4.TabIndex = 5;
            this.label4.Text = "Miejsce zamieszkania:";
            // 
            // text_birth
            // 
            this.text_birth.Location = new System.Drawing.Point(130, 64);
            this.text_birth.Name = "text_birth";
            this.text_birth.Size = new System.Drawing.Size(160, 20);
            this.text_birth.TabIndex = 6;
            // 
            // text_place
            // 
            this.text_place.Location = new System.Drawing.Point(130, 90);
            this.text_place.Name = "text_place";
            this.text_place.Size = new System.Drawing.Size(160, 20);
            this.text_place.TabIndex = 7;
            // 
            // text_surname
            // 
            this.text_surname.Location = new System.Drawing.Point(130, 38);
            this.text_surname.Name = "text_surname";
            this.text_surname.Size = new System.Drawing.Size(160, 20);
            this.text_surname.TabIndex = 8;
            // 
            // AddStudent
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(300, 154);
            this.Controls.Add(this.text_surname);
            this.Controls.Add(this.text_place);
            this.Controls.Add(this.text_birth);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.text_name);
            this.Controls.Add(this.button_addStudent_OK);
            this.Name = "AddStudent";
            this.Text = "AddStudent";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_addStudent_OK;
        private System.Windows.Forms.TextBox text_name;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox text_birth;
        private System.Windows.Forms.TextBox text_place;
        private System.Windows.Forms.TextBox text_surname;
    }
}