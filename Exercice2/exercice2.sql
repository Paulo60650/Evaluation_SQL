-- ex1
SELECT CompanyName AS "Société",
ContactName AS "Contact",
Contacttitle AS "Fonction",
Phone AS "Téléphone"
-- Je sélectionne toutes les valeurs grace à SELECT à renvoyer en renommant les tables
--  pour l'affichage grace à AS 
FROM customers
-- Je donne la table où se situe les valeurs à renvoyer
WHERE Country ="France";
-- WHERE sert a donner une condition obligatoire à la sélection

-- ex2
SELECT ProductName AS "Produit",
UnitPrice AS "Prix"
-- Je sélectionne toutes les valeurs grace à SELECT à renvoyer en renommant les tables
--  pour l'affichage grace à AS 
FROM products
-- Je donne la table où se situe les valeurs à renvoyer
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE CompanyName = "Exotic Liquids";
-- WHERE sert a donner une condition obligatoire à la sélection

-- ex3
SELECT suppliers.CompanyName AS "Fournisseur",
COUNT(products.ProductID) AS "Nbre produits"
FROM suppliers
JOIN products ON products.SupplierID = suppliers.SupplierID
-- Je joint les tables grace à leur clés étrangères grace à JOIN
WHERE Country = "France"
-- WHERE sert a donner une condition obligatoire à la sélection
GROUP BY products.SupplierID
ORDER BY `Nbre produits` DESC;
--J'utilise Order By avec DESC afin d'avoir une organisation décroissante

-- ex4
SELECT customers.CompanyName AS "Client",
COUNT(orders.OrderID) AS "Nbr commandes"
-- La fonction COUNT compte le nombre de valeur de ce qui lui est rentré en paramettre
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
-- Je joint les tables grace à leur clés étrangères grace à JOIN
WHERE Country = "France"
-- WHERE sert a donner une condition obligatoire à la sélection
GROUP BY customers.CompanyName
-- GROUP BY permet de regrouper par valeur identique
HAVING `Nbr commandes` > 10;
-- ex5
SELECT customers.CompanyName AS "Client",
SUM(`order details`.UnitPrice * `order details`.Quantity) AS "CA",
-- Grace à la fonction SUM j'additionne le total de chaque commande
customers.Country AS "Pays"
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
JOIN `order details` ON `order details`.OrderID = orders.OrderID
-- Je joint les tables grace à leur clés étrangères grace à JOIN
GROUP BY customers.CustomerID
-- GROUP BY permet de regrouper par valeur identique
HAVING CA > 30000
-- HAVING me permet de donner une condition d'obligation à ce qui est regroupé par le 
-- GROUP BY comme le ferait un WHERE
ORDER BY CA DESC;
-- ex6
SELECT DISTINCT customers.Country AS "Pays"
-- L'ajout de DISTINCT retire tous les doublons de la liste
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
JOIN `order details` ON `order details`.OrderID = orders.OrderID
JOIN products ON products.ProductID = `order details`. ProductID
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
-- Je joint toutes les tables grace à leur clés étrangères en faisant le chemin jusque
-- la table dont j'ai besoin , à savoir suppliers les 2 tables dont j'ai besoin n'ont 
-- pas de clés étrangères communes
WHERE suppliers.CompanyName = "Exotic Liquids"
-- WHERE sert a donner une condition obligatoire à la sélection
ORDER BY customers.Country;

-- ex7
SELECT SUM(`order details`.UnitPrice * `order details`.Quantity) AS "Montant Ventes 97"
-- Grace à la fonction SUM j'additionne le total de chaque commande
FROM `order details`
JOIN orders ON orders.OrderID = `order details`.OrderID
-- Je joint les tables grace à leur clés étrangères grace à JOIN
WHERE OrderDate LIKE "1997%";
-- WHERE sert a donner une condition obligatoire à la sélection
-- Comme c'est une date américaine je dis ici que je veux que OrderDate commence par 1997
-- le % signifie peu importe ce qu'il y a derrière 1997

-- ex8
SELECT MONTH(orders.OrderDate) AS "Mois 97",
-- La fonction MONTH me permet de sélectionner les mois des dates
SUM(`order details`.UnitPrice * `order details`.Quantity) AS "Montant Ventes"
-- Grace à la fonction SUM j'additionne le total de chaque commande
FROM orders
JOIN `order details` ON `order details`.OrderID = orders.OrderID
-- Je joint les tables grace à leur clés étrangères grace à JOIN
WHERE OrderDate LIKE "1997%"
-- WHERE sert a donner une condition obligatoire à la sélection
-- Comme c'est une date américaine je dis ici que je veux que OrderDate commence par 1997
-- le % signifie peu importe ce qu'il y a derrière 1997
GROUP BY `Mois 97`;

-- ex9
SELECT Max(orders.OrderDate) AS "Date de dernière commande"
-- La fonction Max me permet ici de sélectionner la date la plus réssente étant la plus avancé
FROM orders
JOIN customers ON customers.CustomerID = orders.CustomerID
-- Je joint les tables grace à leur clés étrangères grace à JOIN
WHERE customers.CompanyName = "Du monde entier";
-- WHERE sert a donner une condition obligatoire à la sélection

-- ex10
SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) AS "Délai de livraison moyen"
-- La fonction Round permet d'arrondir un résultat
-- La fonction AVG permet de faire une moyenne
-- La fonction DATEDIFF permet de trouver le nombre de jour entre 2 date
-- Mis en corrélation elles me donnent le délai de livraison moyen
FROM orders;