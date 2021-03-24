﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     Ten kod został wygenerowany przez narzędzie.
//     Wersja wykonawcza:4.0.30319.42000
//
//     Zmiany w tym pliku mogą spowodować nieprawidłowe zachowanie i zostaną utracone, jeśli
//     kod zostanie ponownie wygenerowany.
// </auto-generated>
//------------------------------------------------------------------------------

namespace zad3
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="zad2")]
	public partial class zad2DataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void Insertmiejscowosc(miejscowosc instance);
    partial void Updatemiejscowosc(miejscowosc instance);
    partial void Deletemiejscowosc(miejscowosc instance);
    partial void Insertstudent(student instance);
    partial void Updatestudent(student instance);
    partial void Deletestudent(student instance);
    #endregion
		
		public zad2DataContext() : 
				base(global::zad3.Properties.Settings.Default.zad2ConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public zad2DataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public zad2DataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public zad2DataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public zad2DataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<miejscowosc> miejscowosc
		{
			get
			{
				return this.GetTable<miejscowosc>();
			}
		}
		
		public System.Data.Linq.Table<student> student
		{
			get
			{
				return this.GetTable<student>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.miejscowosc")]
	public partial class miejscowosc : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private string _nazwa;
		
		private EntitySet<student> _student;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnnazwaChanging(string value);
    partial void OnnazwaChanged();
    #endregion
		
		public miejscowosc()
		{
			this._student = new EntitySet<student>(new Action<student>(this.attach_student), new Action<student>(this.detach_student));
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nazwa", DbType="NVarChar(20) NOT NULL", CanBeNull=false, IsPrimaryKey=true)]
		public string nazwa
		{
			get
			{
				return this._nazwa;
			}
			set
			{
				if ((this._nazwa != value))
				{
					this.OnnazwaChanging(value);
					this.SendPropertyChanging();
					this._nazwa = value;
					this.SendPropertyChanged("nazwa");
					this.OnnazwaChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="miejscowosc_student", Storage="_student", ThisKey="nazwa", OtherKey="miejsceZamieszkania")]
		public EntitySet<student> student
		{
			get
			{
				return this._student;
			}
			set
			{
				this._student.Assign(value);
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
		
		private void attach_student(student entity)
		{
			this.SendPropertyChanging();
			entity.miejscowosc = this;
		}
		
		private void detach_student(student entity)
		{
			this.SendPropertyChanging();
			entity.miejscowosc = null;
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.student")]
	public partial class student : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _id;
		
		private string _imie;
		
		private string _nazwisko;
		
		private string _miejsceZamieszkania;
		
		private System.DateTime _dataUrodzenia;
		
		private EntityRef<miejscowosc> _miejscowosc;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnidChanging(int value);
    partial void OnidChanged();
    partial void OnimieChanging(string value);
    partial void OnimieChanged();
    partial void OnnazwiskoChanging(string value);
    partial void OnnazwiskoChanged();
    partial void OnmiejsceZamieszkaniaChanging(string value);
    partial void OnmiejsceZamieszkaniaChanged();
    partial void OndataUrodzeniaChanging(System.DateTime value);
    partial void OndataUrodzeniaChanged();
    #endregion
		
		public student()
		{
			this._miejscowosc = default(EntityRef<miejscowosc>);
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_id", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int id
		{
			get
			{
				return this._id;
			}
			set
			{
				if ((this._id != value))
				{
					this.OnidChanging(value);
					this.SendPropertyChanging();
					this._id = value;
					this.SendPropertyChanged("id");
					this.OnidChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_imie", DbType="NVarChar(20) NOT NULL", CanBeNull=false)]
		public string imie
		{
			get
			{
				return this._imie;
			}
			set
			{
				if ((this._imie != value))
				{
					this.OnimieChanging(value);
					this.SendPropertyChanging();
					this._imie = value;
					this.SendPropertyChanged("imie");
					this.OnimieChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_nazwisko", DbType="NVarChar(20) NOT NULL", CanBeNull=false)]
		public string nazwisko
		{
			get
			{
				return this._nazwisko;
			}
			set
			{
				if ((this._nazwisko != value))
				{
					this.OnnazwiskoChanging(value);
					this.SendPropertyChanging();
					this._nazwisko = value;
					this.SendPropertyChanged("nazwisko");
					this.OnnazwiskoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_miejsceZamieszkania", DbType="NVarChar(20) NOT NULL", CanBeNull=false)]
		public string miejsceZamieszkania
		{
			get
			{
				return this._miejsceZamieszkania;
			}
			set
			{
				if ((this._miejsceZamieszkania != value))
				{
					if (this._miejscowosc.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnmiejsceZamieszkaniaChanging(value);
					this.SendPropertyChanging();
					this._miejsceZamieszkania = value;
					this.SendPropertyChanged("miejsceZamieszkania");
					this.OnmiejsceZamieszkaniaChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_dataUrodzenia", DbType="Date NOT NULL")]
		public System.DateTime dataUrodzenia
		{
			get
			{
				return this._dataUrodzenia;
			}
			set
			{
				if ((this._dataUrodzenia != value))
				{
					this.OndataUrodzeniaChanging(value);
					this.SendPropertyChanging();
					this._dataUrodzenia = value;
					this.SendPropertyChanged("dataUrodzenia");
					this.OndataUrodzeniaChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="miejscowosc_student", Storage="_miejscowosc", ThisKey="miejsceZamieszkania", OtherKey="nazwa", IsForeignKey=true)]
		public miejscowosc miejscowosc
		{
			get
			{
				return this._miejscowosc.Entity;
			}
			set
			{
				miejscowosc previousValue = this._miejscowosc.Entity;
				if (((previousValue != value) 
							|| (this._miejscowosc.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._miejscowosc.Entity = null;
						previousValue.student.Remove(this);
					}
					this._miejscowosc.Entity = value;
					if ((value != null))
					{
						value.student.Add(this);
						this._miejsceZamieszkania = value.nazwa;
					}
					else
					{
						this._miejsceZamieszkania = default(string);
					}
					this.SendPropertyChanged("miejscowosc");
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
}
#pragma warning restore 1591