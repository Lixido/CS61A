passphrase = '*** PASSPHRASE HERE ***'

def survey(p):
    """
    You do not need to understand this code.
    >>> survey(passphrase)
    '3d2eea56786a3d9e503a4c07dd667867ef3d92bfccd68b2aa0900ead'
    """
    import hashlib
    return hashlib.sha224(p.encode('utf-8')).hexdigest()
# midterm related survey, not relevant to me

class Fib():
    """A Fibonacci number.

    >>> start = Fib()
    >>> start
    0
    >>> start.next()
    1
    >>> start.next().next()
    1
    >>> start.next().next().next()
    2
    >>> start.next().next().next().next()
    3
    >>> start.next().next().next().next().next()
    5
    >>> start.next().next().next().next().next().next()
    8
    >>> start.next().next().next().next().next().next() # Ensure start isn't changed
    8
    """

    def __init__(self, value=0):
        self.value = value

    def next(self):
        if self.value == 0:
        '''It is incorrect to write: self is Fib() or self == Fib(),
        which is a characteristic of python; or you can rewrite the logic of ==:
        def __eq__(self,other):
            return self.__dict__ == other.__dict__
        # if all attributes are equal, then the two instances are equal
        Normally, we just compare some distinctive attribute to get the result.
        '''
            self.previous = 1
        next_fib = Fib(self.previous + self.value)
        next_fib.previous = self.value
        return next_fib

    def __repr__(self):
        return str(self.value)

class VendingMachine:
    """A vending machine that vends some product for some price.

    >>> v = VendingMachine('candy', 10)
    >>> v.vend()
    'Machine is out of stock.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'
    >>> v.restock(2)
    'Current candy stock: 2'
    >>> v.vend()
    'You must deposit $10 more.'
    >>> v.deposit(7)
    'Current balance: $7'
    >>> v.vend()
    'You must deposit $3 more.'
    >>> v.deposit(5)
    'Current balance: $12'
    >>> v.vend()
    'Here is your candy and $2 change.'
    >>> v.deposit(10)
    'Current balance: $10'
    >>> v.vend()
    'Here is your candy.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'

    >>> w = VendingMachine('soda', 2)
    >>> w.restock(3)
    'Current soda stock: 3'
    >>> w.restock(3)
    'Current soda stock: 6'
    >>> w.deposit(2)
    'Current balance: $2'
    >>> w.vend()
    'Here is your soda.'
    """
    quantity = 0
    balance = 0

    def __init__(self, product, price):
        self.product = product
        self.price = price

    def restock(self, number):
        self.quantity += number
        return 'Current {0} stock: {1}'.format(self.product, self.quantity)
        '''Hint:
        >>> ten, twenty, thirty = 10, 'twenty', [30]
        >>> '{0} plus {1} is {2}'.format(ten, twenty, thirty)
            '10 plus twenty is [30]'
        Note: {} begins with 0!
        '''

    def deposit(self, money):
        if self.quantity == 0:
            return 'Machine is out of stock. Here is your ${0}.'.format(money)
        else:
            self.balance += money
            return 'Current balance: ${0}'.format(self.balance)

    def vend(self):
        dif = self.price - self.balance
        if self.quantity == 0:
            return 'Machine is out of stock.'
        if dif > 0:
            return 'You must deposit ${0} more.'.format(dif)
        else:
            self.balance = 0
            self.quantity -= 1
            if dif == 0:
                return 'Here is your {0}.'.format(self.product)
            else:
                return 'Here is your {0} and ${1} change.'.format(self.product, -dif)

