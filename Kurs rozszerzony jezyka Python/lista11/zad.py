from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Table, Column, Integer, ForeignKey, String, DateTime
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import relationship

from tkinter import *

#Tworzenie tabeli w bazie
engine = create_engine('sqlite:///baza.db', echo=False)
Base = declarative_base()

class Person(Base):
    __tablename__ = 'Person'
    id = Column(Integer, primary_key=True)
    name = Column(String(20), nullable=False)
    mail = Column(String)
    borrowed = relationship('Book', backref = 'borrowed_by')
class Book(Base):
    __tablename__ = 'Book'
    id = Column(Integer, primary_key=True)
    author = Column(String)
    title = Column(String)
    year = Column(String)
    borrowed_by_id = Column(Integer, ForeignKey('Person.id'),nullable = 'True')

Base.metadata.create_all(engine)

def add_book(title, author, year):
    if title and author and year:
        Session = sessionmaker(bind = engine)
        session = Session()
        book = Book(title = title, author = author, year = year)
        session.add(book)
        session.commit()
        session.close()

def add_friend(name, mail):
    if name and mail:
        Session = sessionmaker(bind = engine)
        session = Session()
        friend = Person(name = name, mail = mail)
        session.add(friend)
        session.commit()
        session.close()


#Tworzenie okna i przycisków
root = Tk()
root.title("Book database")

label1 = Label(root, text = "Choose your action", borderwidth = 10)
label1.grid(row = 0, column = 0, columnspan = 2)

#funkcje baza i okno
def show_friends_button():
    top = Toplevel()
    top.title("Friends list")
    Session = sessionmaker(bind = engine)
    session = Session()
    result = session.query(Person).all()
    print_records = ""
    for row in result:
        print_records += str(row.id) + " " + str(row.name) + " " + str(row.mail) + " wypożyczone książki: " + " ".join([b.title for b in row.borrowed]) + "\n\n"

    quary_label = Label(top, text = print_records, justify = 'left', borderwidth = 5)
    quary_label.grid(row = 0, column = 0)
    session.close()

def show_books_button():
    top = Toplevel()
    top.title("Books list")
    Session = sessionmaker(bind = engine)
    session = Session()
    result = session.query(Book).all()
    print_records = ""
    for row in result:
        if row.borrowed_by is None:
            print_records += str(row.id) + " " + str(row.title) + " " + str(row.author) +  " " + str(row.year) + "\n\n"
        else:
            print_records += str(row.id) + " " + str(row.title) + " " + str(row.author) +  " " + str(row.year) + " wypożyczone przez: " + str(row.borrowed_by.name) + "\n\n"

    quary_label = Label(top, text = print_records, justify = 'left',borderwidth = 5)
    quary_label.grid(row = 0, column = 0)
    session.close()

def add_book_button():
    top = Toplevel()
    top.title("Add book")
    label_title = Label(top, text = "Book title", borderwidth = 5)
    entry_title = Entry(top, width = 30)
    label_author = Label(top, text = "Book author", borderwidth = 5)
    entry_author = Entry(top, width = 30)
    label_year = Label(top, text= "Year published", borderwidth = 5)
    entry_year = Entry(top, width = 30)
    button_accept = Button(top,text= "Accept", command = lambda: [add_book(entry_title.get(), entry_author.get(), entry_year.get()), top.destroy()])

    label_title.grid(row = 0, column = 0)
    entry_title.grid(row = 0, column =1)
    label_author.grid(row = 1, column = 0)
    entry_author.grid(row = 1, column = 1)
    label_year.grid(row = 2, column = 0)
    entry_year.grid(row = 2, column = 1)
    button_accept.grid(row = 3, column = 0, columnspan = 2)

def add_friend_button():
    top = Toplevel()
    top.title("Add friend")
    label_name = Label(top, text = "Friend name", borderwidth = 5)
    entry_name = Entry(top, width = 30)
    label_email = Label(top, text = "Friend email", borderwidth = 5)
    entry_email = Entry(top, width = 30)
    button_accept = Button(top,text= "Accept", command = lambda: [add_friend(entry_name.get(), entry_email.get()), top.destroy()])

    label_name.grid(row = 0, column = 0)
    entry_name.grid(row = 0, column =1)
    label_email.grid(row = 1, column = 0)
    entry_email.grid(row = 1, column = 1)
    button_accept.grid(row = 2, column = 0, columnspan = 2)

def borrow_button3(person,book):
    global session
    book.borrowed_by = person
    session.commit()
    session.close()

def borrow_button2(person):
    books = session.query(Book).filter(Book.borrowed_by == None).all()
    titles = [book.title for book in books]
    dic = {book.title: book for book in books}
    clicked = StringVar()
    clicked.set(titles[0])
    drop = OptionMenu(top, clicked, *titles)
    button_name = Button(top,text= "Accept", command = lambda: [borrow_button3(person,dic[clicked.get()]), top.destroy()])
    drop.grid(row=1,column=0)
    button_name.grid(row = 1, column = 1)

def borrow_button():
    global top
    top = Toplevel()
    top.geometry("200x75")
    top.title("Return book")

    Session = sessionmaker(bind = engine)
    global session
    session = Session()
    person = session.query(Person).all()
    dic = {row.name: row for row in person}
    names = [row.name for row in person]
    clicked = StringVar()
    clicked.set(names[0])
    drop = OptionMenu(top, clicked, *names)
    button_name = Button(top,text= "Accept", command = lambda: borrow_button2(dic[clicked.get()]))
    drop.grid(row=0,column=0)
    button_name.grid(row = 0, column = 1)

def ret_button3(book):
    global session
    book.borrowed_by = None
    session.commit()
    session.close()

def ret_button2(person):
    books = person.borrowed
    titles = [book.title for book in books]
    dic = {book.title: book for book in books}
    clicked = StringVar()
    clicked.set(titles[0])
    drop = OptionMenu(top, clicked, *titles)
    button_name = Button(top,text= "Accept", command = lambda: [ret_button3(dic[clicked.get()]), top.destroy()])
    drop.grid(row=1,column=0)
    button_name.grid(row = 1, column = 1)


def ret_button():
    global top
    top = Toplevel()
    top.geometry("200x75")
    top.title("Return book")

    Session = sessionmaker(bind = engine)
    global session
    session = Session()
    person = session.query(Person).filter(Person.borrowed != None).all()
    dic = {row.name: row for row in person}
    names = [row.name for row in person]
    clicked = StringVar()
    clicked.set(names[0])
    drop = OptionMenu(top, clicked, *names)
    button_name = Button(top,text= "Accept", command = lambda: ret_button2(dic[clicked.get()]))
    drop.grid(row=0,column=0)
    button_name.grid(row = 0, column = 1)



button_show_f = Button(root, text="Show friends",padx= 40, pady = 20, command = show_friends_button)
button_show_b = Button(root, text="Show books",padx= 42, pady = 20, command = show_books_button)
button_add_f = Button(root, text="Add friend",padx= 47, pady = 20, command = add_friend_button)
button_add_b = Button(root, text="Add book",padx= 48, pady = 20, command = add_book_button)
button_borrow = Button(root, text="Borrow book",padx= 122, pady = 20, command = borrow_button)
button_return = Button(root, text="Return book",padx= 122, pady = 20, command = ret_button)

button_show_f.grid(row = 1, column = 0)
button_show_b.grid(row = 1, column = 1)
button_add_f.grid(row = 2, column = 0)
button_add_b.grid(row = 2, column = 1)
button_borrow.grid(row = 3, column = 0,columnspan = 2)
button_return.grid(row = 4, column = 0,columnspan = 2)





root.mainloop()
