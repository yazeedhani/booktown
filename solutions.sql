-- ### Order
-- 1. Find all subjects sorted by subject
select * from subjects order by subject;
-- OUTPUT
-- id |     subject      |     location
-- ----+------------------+------------------
--   0 | Arts             | Creativity St
--   1 | Business         | Productivity Ave
--   2 | Children's Books | Kids Ct
--   3 | Classics         | Academic Rd
--   4 | Computers        | Productivity Ave
--   5 | Cooking          | Creativity St
--   6 | Drama            | Main St
--   7 | Entertainment    | Main St
--   8 | History          | Academic Rd
--   9 | Horror           | Black Raven Dr
--  10 | Mystery          | Black Raven Dr
--  11 | Poetry           | Sunset Dr
--  12 | Religion         |
--  13 | Romance          | Main St
--  14 | Science          | Productivity Ave
--  15 | Science Fiction  | Main St
-- (16 rows)

-- 2. Find all subjects sorted by location
select * from subjects order by location;
-- id |     subject      |     location
-- ----+------------------+------------------
--   8 | History          | Academic Rd
--   3 | Classics         | Academic Rd
--  10 | Mystery          | Black Raven Dr
--   9 | Horror           | Black Raven Dr
--   0 | Arts             | Creativity St
--   5 | Cooking          | Creativity St
--   2 | Children's Books | Kids Ct
--   7 | Entertainment    | Main St
--   6 | Drama            | Main St
--  13 | Romance          | Main St
--  15 | Science Fiction  | Main St
--  14 | Science          | Productivity Ave
--   4 | Computers        | Productivity Ave
--   1 | Business         | Productivity Ave
--  11 | Poetry           | Sunset Dr
--  12 | Religion         |
-- (16 rows)

-- ### Where
-- 3. Find the book "Little Women"
select * from books where title='Little Women';
--  id  |    title     | author_id | subject_id
-- -----+--------------+-----------+------------
--  190 | Little Women |        16 |          6
-- (1 row)

-- 4. Find all books containing the word "Python"
select * from books where title like '%Python%';
--   id   |       title        | author_id | subject_id
-- -------+--------------------+-----------+------------
--  41473 | Programming Python |      7805 |          4
--  41477 | Learning Python    |      7805 |          4
-- (2 rows)

-- 5. Find all subjects with the location "Main St" sort them by subject
select * from subjects where location='Main St';
--  id |     subject     | location
-- ----+-----------------+----------
--   6 | Drama           | Main St
--   7 | Entertainment   | Main St
--  13 | Romance         | Main St
--  15 | Science Fiction | Main St
-- (4 rows)

-- ### Joins

-- 6. Find all books about Computers and list ONLY the book titles
select title from books join subjects on books.subject_id=subjects.id where subjects.subject='Computers';
--         title
-- ----------------------
--  Practical PostgreSQL
--  Perl Cookbook
--  Learning Python
--  Programming Python
-- (4 rows)

-- 7. Find all books and display a result table with ONLY the following columns
-- 	* Book title
-- 	* Author's first name
-- 	* Author's last name
-- 	* Book subject
select books.title, authors.first_name, authors.last_name, subjects.subject from books join authors on books.author_id=authors.id join subjects on books.subject_id=subjects.id;
--             title            |    first_name    |  last_name   |     subject
-- -----------------------------+------------------+--------------+------------------
--  Practical PostgreSQL        | John             | Worsley      | Computers
--  Franklin in the Dark        | Paulette         | Bourgeois    | Children's Books
--  The Velveteen Rabbit        | Margery Williams | Bianco       | Classics
--  Little Women                | Louisa May       | Alcott       | Drama
--  The Shining                 | Stephen          | King         | Horror
--  Dune                        | Frank            | Herbert      | Science Fiction
--  Dynamic Anatomy             | Burne            | Hogarth      | Arts
--  Goodnight Moon              | Margaret Wise    | Brown        | Children's Books
--  The Tell-Tale Heart         | Edgar Allen      | Poe          | Horror
--  Programming Python          | Mark             | Lutz         | Computers
--  Learning Python             | Mark             | Lutz         | Computers
--  Perl Cookbook               | Tom              | Christiansen | Computers
--  2001: A Space Odyssey       | Arthur C.        | Clarke       | Science Fiction
--  The Cat in the Hat          | Theodor Seuss    | Geisel       | Children's Books
--  Bartholomew and the Oobleck | Theodor Seuss    | Geisel       | Children's Books
-- (15 rows)

-- 8. Find all books that are listed in the stock table
-- 	* Sort them by retail price (most expensive first)
-- 	* Display ONLY: title and price
select books.title, stock.retail from editions join books on editions.book_id=books.id join stock on editions.isbn=stock.isbn order by stock.retail desc;
--             title            | retail
-- -----------------------------+--------
--  2001: A Space Odyssey       |  46.95
--  Dune                        |  45.95
--  The Shining                 |  36.95
--  The Cat in the Hat          |  32.95
--  Goodnight Moon              |  28.95
--  The Shining                 |  28.95
--  Dynamic Anatomy             |  28.95
--  The Tell-Tale Heart         |  24.95
--  The Velveteen Rabbit        |  24.95
--  The Cat in the Hat          |  23.95
--  Franklin in the Dark        |  23.95
--  Little Women                |  23.95
--  2001: A Space Odyssey       |  22.95
--  The Tell-Tale Heart         |  21.95
--  Dune                        |  21.95
--  Bartholomew and the Oobleck |  16.95
-- (16 rows)

-- 9. Find the book "Dune" and display ONLY the following columns
-- 	* Book title
-- 	* ISBN number
-- 	* Publisher name
-- 	* Retail price
select books.title, editions.isbn, publishers.name, stock.retail from editions join books on editions.book_id=books.id join publishers on editions.publisher_id=publishers.id join stock on editions.isbn=stock.isbn;
--             title            |    isbn    |            name             | retail
-- -----------------------------+------------+-----------------------------+--------
--  The Cat in the Hat          | 039480001X | Random House                |  32.95
--  The Shining                 | 0451160916 | Doubleday                   |  28.95
--  Bartholomew and the Oobleck | 0394800753 | Random House                |  16.95
--  Franklin in the Dark        | 0590445065 | Kids Can Press              |  23.95
--  Goodnight Moon              | 0694003611 | HarperCollins               |  28.95
--  The Velveteen Rabbit        | 0679803335 | Penguin                     |  24.95
--  Little Women                | 0760720002 | Henry Holt & Company, Inc.  |  23.95
--  The Cat in the Hat          | 0394900014 | Random House                |  23.95
--  The Shining                 | 0385121679 | Doubleday                   |  36.95
--  The Tell-Tale Heart         | 1885418035 | Mojo Press                  |  24.95
--  The Tell-Tale Heart         | 0929605942 | Books of Wonder             |  21.95
--  Dune                        | 0441172717 | Ace Books                   |  21.95
--  Dune                        | 044100590X | Ace Books                   |  45.95
--  2001: A Space Odyssey       | 0451457994 | Roc                         |  22.95
--  2001: A Space Odyssey       | 0451198492 | Roc                         |  46.95
--  Dynamic Anatomy             | 0823015505 | Watson-Guptill Publications |  28.95
-- (16 rows)

-- 10. Find all shipments sorted by ship date display a result table with ONLY the following columns:
-- 	* Customer first name
-- 	* Customer last name
-- 	* ship date
-- 	* book title
select customers.first_name, customers.last_name, shipments.ship_date from customers join shipments on customers.id=shipments.customer_id order by ship_date;

-- ### Grouping and Counting

-- 11. Get the COUNT of all books
select count(id) from books;
--  count
-- -------
--     15
-- (1 row)

-- 12. Get the COUNT of all Locations
select count(distinct location) from subjects where location is not null;
--  count
-- -------
--      7
-- (1 row)

-- 13. Get the COUNT of each unique location in the subjects table. Display the count and the location name. (hint: requires GROUP BY).
select count(location), location from subjects where location is not null group by location;
--  count |     location
-- -------+------------------
--      1 | Sunset Dr
--      1 | Kids Ct
--      2 | Black Raven Dr
--      2 | Creativity St
--      2 | Academic Rd
--      4 | Main St
--      3 | Productivity Ave
-- (7 rows)

-- 14. List all books. Display the book_id, title, and a count of how many editions each book has. (hint: requires GROUP BY and JOIN)
select editions.book_id, books.title, count(editions.edition) from editions join books on editions.book_id=books.id group by editions.book_id, books.title;
--  book_id |            title            | count
-- ---------+-----------------------------+-------
--     1234 | The Velveteen Rabbit        |     1
--    25908 | Franklin in the Dark        |     1
--     1501 | Goodnight Moon              |     1
--    41473 | Programming Python          |     1
--     1590 | Bartholomew and the Oobleck |     1
--      156 | The Tell-Tale Heart         |     2
--      190 | Little Women                |     1
--     7808 | The Shining                 |     2
--     1608 | The Cat in the Hat          |     2
--     4267 | 2001: A Space Odyssey       |     2
--     4513 | Dune                        |     2
--     2038 | Dynamic Anatomy             |     1
-- (12 rows)