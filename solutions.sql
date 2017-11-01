-- PRACTICE JOINS

-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.

SELECT * 
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
WHERE il.UnitPrice > 0.99;

-- Get the InvoiceDate, customer FirstName and LastName, and Total from all invoices.

SELECT i.InvoiceDate, c.FirstName, c.LastName, i.Total 
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId;

-- Get the customer FirstName and LastName and the support rep's FirstName and LastName from all customers.

SELECT c.FirstName, c.LastName, e.FirstNAme, e.LastName
FROM Customer c
JOIN Employee e ON c.SupportRepId = e.EmployeeId;

-- Get the album Title and the artist Name from all albums.

SELECT al.Title, ar.Name 
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId;

-- Get all PlaylistTrack TrackIds where the playlist Name is Music.

SELECT pt.TrackId 
FROM Playlist pl 
JOIN PlaylistTrack pt ON pl.PlaylistId = pt.playlistId
WHERE pl.Name = 'Music';

-- Get all Track Names for PlaylistId 5.

SELECT t.Name
FROM Track t
JOIN PlaylistTrack pl ON t.TrackId = pl.TrackId
WHERE pl.PlaylistId = 5;

-- Get all Track Names and the playlist Name that they're on ( 2 joins ).

SELECT t.Name, pl.Name 
FROM Track t
JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId
JOIN Playlist pl ON pt.PlaylistId = pl.PlaylistId;

-- Get all Track Names and Album Titles that are the genre "Alternative" ( 2 joins ).

SELECT t.Name, a.Title 
FROM Track t 
JOIN Album a ON a.AlbumId = t.AlbumId
JOIN Genre g ON g.GenreId = t.GenreId
WHERE g.Name = 'Alternative';



-- PRACTICE NESTED QUERIES

-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.

SELECT *
FROM Invoice
WHERE InvoiceId IN (SELECT InvoiceId FROM InvoiceLine WHERE UnitPrice > 0.99);

-- Get all Playlist Tracks where the playlist name is Music.

SELECT * 
FROM PlaylistTrack
WHERE PlaylistId IN (SELECT PlaylistId FROM Playlist WHERE Name = 'Music');

-- Get all Track names for PlaylistId 5.

SELECT Name 
FROM Track 
WHERE TrackId IN (SELECT TrackId FROM PlaylistTrack WHERE PlaylistId = 5);

-- Get all tracks where the Genre is Comedy.

SELECT Name 
FROM Track 
WHERE GenreId IN (SELECT GenreId FROM Genre WHERE Name = 'Comedy');

-- Get all tracks where the Album is Fireball.

SELECT *
FROM Track 
WHERE AlbumId IN (SELECT AlbumId FROM Album WHERE Title = 'Fireball');

-- Get all tracks for the artist Queen ( 2 nested subqueries ).

SELECT *
FROM Track
WHERE AlbumId IN ( 
  SELECT AlbumId FROM Album WHERE ArtistId IN ( 
    SELECT ArtistId FROM Artist WHERE Name = "Queen" 
  )
); 



-- PRACTICE UPDATING ROWS

-- Find all customers with fax numbers and set those numbers to null.

UPDATE Customer
SET Fax = null 
WHERE Fax IS NOT null;

-- Find all customers with no company (null) and set their company to "Self".

UPDATE Customer 
SET Company = "Self"
WHERE Company IS null;


-- Find the customer Julia Barnett and change her last name to Thompson.

UPDATE Customer
SET LastName = "Thompson"
WHERE FirstName = "Julia" AND LastName = "Barnett"

-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.

UPDATE Customer
SET SupportRepId = 4
WHERE Email = "luisrojas@yahoo.cl";

-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".

UPDATE Track
SET Composer = "The darkness around us"
WHERE Composer IS NULL AND GenreId = (SELECT GenreID FROM Genre WHERE Name = "Metal");




-- GROUP BY

-- Find a count of how many tracks there are per genre. Display the genre name with the count.

SELECT Count(*), g.Name
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;

-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.

SELECT Count(*), g.Name
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.Name = 'Pop' OR g.Name = 'Rock'
GROUP BY g.Name;

-- Find a list of all artists and how many albums they have.

SELECT ar.Name, Count(*)
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId
GROUP BY al.Artistid;



-- DISTINCT


-- From the Track table find a unique list of all Composers.

SELECT DISTINCT Composer
FROM Track;

-- From the Invoice table find a unique list of all BillingPostalCodes.

SELECT DISTINCT BillingPostalCode
FROM Invoice;

-- From the Customer table find a unique list of all Companys.

SELECT DISTINCT Company
FROM Customer;



-- DELETE ROWS


-- Delete all "bronze" entries from the table.

DELETE FROM practice_delete
WHERE Type = "bronze";

-- Delete all "silver" entries from the table.

DELETE FROM practice_delete
WHERE Type = "silver";

-- Delete all entries whose value is equal to 150.

DELETE FROM practice_delete
WHERE Value = 150;
