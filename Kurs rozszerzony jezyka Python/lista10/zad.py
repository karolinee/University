from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Table, Column, Integer, ForeignKey, String, DateTime
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import relationship



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

def add_friend():
    Session = sessionmaker(bind = engine)
    session = Session()
    name = input('Podaj imie ')
    mail = input('Podaj email ')
    friend = Person(name = name, mail = mail)
    session.add(friend)
    session.commit()
    session.close()

def add_book():
    Session = sessionmaker(bind = engine)
    session = Session()
    title = input('Podaj tytul ')
    author = input('Podaj autora ')
    year = input('Podaj rok ')
    book = Book(title = title, author = author, year = year)
    session.add(book)
    session.commit()
    session.close()

def show_friends():
    Session = sessionmaker(bind = engine)
    session = Session()
    result = session.query(Person).all()
    for row in result:
       print ("Id: ", row.id, ", imie: ",row.name, ", email: ",row.mail, ', wypożyczone książki: ', [b.title for b in row.borrowed])
    session.close()

def show_books():
    Session = sessionmaker(bind = engine)
    session = Session()
    result = session.query(Book).all()
    for row in result:
        if row.borrowed_by is None:
            print ("Id: ", row.id, ", tytuł: ",row.title, ", autor: ",row.author, ", rok: ",row.year, ' wypożyczone przez: - ')
        else:
            print ("Id: ", row.id, ", tytuł: ",row.title, ", autor: ",row.author, ", rok: ",row.year, ' wypożyczone przez: ', row.borrowed_by.name)
    session.close()

def borrow():
    Session = sessionmaker(bind = engine)
    session = Session()
    person_name = input('Podaj osobę która wypozycza ')
    book_title = input('Podaj tytuł książki ')
    person = session.query(Person).filter(Person.name == person_name).first()
    book = session.query(Book).filter(Book.title == book_title).first()
    if person is None or book is None:
        print("brak takich danych w bazie")
    else:
        if book.borrowed_by is None:
            book.borrowed_by = person
            session.commit()
        else: print("Książka jest już wypozyczona")
    session.close()

def ret():
    Session = sessionmaker(bind = engine)
    session = Session()
    person_name = input('Podaj osobę która oddaje ')
    person = session.query(Person).filter(Person.name == person_name).first()
    if person is None:
        print("brak takich danych w bazie")
    else:
        books = person.borrowed
        if not books:
            print("Ta osoba nie ma wypozyczonej książki")
        else:
            if len(books) > 1:
                book_title = input('Podaj tytuł książki ')
                book = session.query(Book).filter(Book.title == book_title).first()
            else: book = books[0]
            book.borrowed_by = None
            session.commit()
    session.close()

import sys
command_map = {
           "show_books": show_books,
           "show_friends": show_friends,
           "add_book": add_book,
           "add_friend": add_friend,
           "borrow": borrow,
           "return": ret}
if sys.argv[1:]:
    try:
        action = command_map[sys.argv[1]]
        action()
    except:
        print("nieznane polecenie, spróbuj: show_friends, show_books, add_friend, add_book, borrow, return")
