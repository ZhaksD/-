import pandas as pd
import matplotlib.pyplot as plt

# загрузка данных
customers = pd.read_csv('customers.csv')
accounts = pd.read_csv('accounts.csv')
transactions = pd.read_csv('transactions.csv')

#  CUSTOMERS
print("CUSTOMERS")
print(customers.info())
print(customers.isnull().sum())
print(customers.describe())

#  ACCOUNTS
print("\nACCOUNTS")
print(accounts.info())
print(accounts.describe())

#  TRANSACTIONS
print("\nTRANSACTIONS")
print(transactions.info())
print(transactions.isnull().sum())
print(transactions.describe())

# распределение транзакций
transactions['amount'].hist(bins=50)
plt.title('Transaction Amount Distribution')
plt.show()

# выбросы
transactions.boxplot(column='amount')
plt.show()

# категории
print(transactions['category'].value_counts())
print(transactions['type'].value_counts())