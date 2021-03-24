import itertools

class Formula:
    def set_variables(self, variables):
        #tworzenie zbioru zmiennych (jest to set by uniknać powtórzeń)
        if isinstance(self,Variable):
            variables.add(self.name)
            return variables
        if isinstance(self, (Prawda, Falsz)):
            return variables
        if isinstance(self, Neg):
            return self.first_arg.set_variables(variables)
        return self.first_arg.set_variables(variables) | self.second_arg.set_variables(variables)

    # def true_false_evaluation(self, number_of_elem):
    #     #lista możliwych wartościowań podanej ilości zmiennych
    #     p = [[]]
    #     for i in range(number_of_elem):
    #         p = itertools.chain.from_iterable((e + [True], e + [False]) for e in p)
    #
    #     return list(p)

    def tautologia(self):
        # #sprawdzanie czy formuła jest tautologią
        # var = list(self.set_variables(set())) #list zmiennych wystepujących w formule
        # number_of_var = len(var) #ilośc zmiennych w formule
        # perm = self.true_false_evaluation(number_of_var) #wszystkie możliwe wartościowanie konkretnej iosci zmiennych
        # for i in range(len(perm)): #sprawdzanie czy każde wartościowanie zwraca True (jeśli nie to koniec pętli i zwracamy False)
        #     var_eval = {var[j]: perm[i][j] for j in range(number_of_var)}
        #     if not self.oblicz(var_eval):
        #         return False
        # return True

        var = list(self.set_variables(set()))
        number_of_var = len(var)
        for i in range(2**(number_of_var-1)):
            perm = bin(i)[2:].zfill(number_of_var)
            var_eval = {var[j]: int(perm[j]) for j in range(number_of_var)}
            if not self.oblicz(var_eval):
                return False
        return True




class Impl(Formula):
    def __init__(self,first, second):
        self.first_arg = first
        self.second_arg = second
    def oblicz(self,zmienne):
        #nieprawdziwe gdy prawda implikuje fałsz (po przekształceniu ¬(a=>b) = ¬(a∧¬b)=¬avb
        return not self.first_arg.oblicz(zmienne) or self.second_arg.oblicz(zmienne)
    def __str__(self):
        return f'({self.first_arg} => {self.second_arg})'


class And(Formula):
    def __init__(self,first, second):
        self.first_arg = first
        self.second_arg = second
    def oblicz(self,zmienne):
        return self.first_arg.oblicz(zmienne) and self.second_arg.oblicz(zmienne)
    def __str__(self):
        return f'({self.first_arg} ∧ {self.second_arg})'


class Or(Formula):
    def __init__(self,first, second):
        self.first_arg = first
        self.second_arg = second
    def oblicz(self,zmienne):
        return self.first_arg.oblicz(zmienne) or self.second_arg.oblicz(zmienne)
    def __str__(self):
        return f'({self.first_arg} v {self.second_arg})'


class Equiv(Formula):
    def __init__(self,first, second):
        self.first_arg = first
        self.second_arg = second
    def oblicz(self,zmienne):
        return self.first_arg.oblicz(zmienne) == self.second_arg.oblicz(zmienne)
    def __str__(self):
        return f'({self.first_arg} <=> {self.second_arg})'


class Neg(Formula):
    def __init__(self,first):
        self.first_arg = first
    def oblicz(self,zmienne):
        return not self.first_arg.oblicz(zmienne)
    def __str__(self):
        return f'¬({self.first_arg})'


class Prawda(Formula):
    def oblicz(self, zmienne):
        return True
    def __str__(self):
        return 'true'


class Falsz(Formula):
    def oblicz(self, zmienne):
        return False
    def __str__(self):
        return 'false'


class Variable(Formula):
    def __init__(self, name):
        self.name = name
    def oblicz(self, zmienne):
        return zmienne[self.name]
    def __str__(self):
        return f'{self.name}'




# testy
f1 = Or(Variable('p'),Neg(Variable('p')))
print(f1)
print(f1.tautologia(), end='\n\n')

f2 = And(Variable('q'),Neg(Variable('q')))
print(f2)
print(f2.tautologia(), end='\n\n')

f3 = Impl(Prawda(),Variable('r'))
print(f3)
print(f3.oblicz({'r': Falsz()}))
print(f3.oblicz({'r': Prawda()}), end='\n\n')

f4 = Equiv(Prawda(),Prawda())
print(f4)
print(f4.oblicz([]), end='\n\n')

f5 = Equiv(Prawda(),Falsz())
print(f5)
print(f5.oblicz([]))
