drop table Painter cascade constraints;
drop table Gallery cascade constraints;
drop table Painting cascade constraints;


-- ************************************** TABLE CREATION AND INSERT STATEMENTS *****************************************

-- Painter
create table Painter(
Painter_No char(3),
Lastname varchar2(20),
Firstname varchar2(30),
Areacode char(3),
Phone char(15),
constraint PKPainter_No primary key (Painter_No) );

insert into Painter
values ('123', 'Ross', 'Georgette', '901', '8854567');

insert into Painter
values ('126','Itero','Julio','901','3461112');

insert into Painter
values ('127','Geoff','George','615','2214456');


-- Gallery
create table Gallery(
Gallery_No Integer,
Owner varchar2(50),
Areacode char(3),
Phone char(15),
Rate decimal(3, 3), 
constraint PKGallery_No primary key (Gallery_No) );

insert into Gallery
values (5,'L.R. Gilliam', '901', '1234456', 0.37);

insert into Gallery
values (6, 'G.G. Waters', '405', '3532243', 0.45);


-- Painting
create table Painting(
Painting_No char (4),
Title varchar2(50),
Completion_Date date,
Price decimal(12, 2) default 0, 
Painter_No char(3),
Gallery_No Integer,
constraint PKPainting_No primary key (Painting_No),
constraint FKPainter_No foreign key (Painter_No) references Painter,
constraint FKGallery_No foreign key (Gallery_No) references Gallery );

insert into Painting
values ('1338', 'Dawn Thunder','08/15/2004', 245.50, '123', 5);

insert into Painting
values ('1339', 'A Faded Rose', '07/22/2003', 6273.00, '123', null);

insert into Painting
values ('1340', 'The Founders', '12/20/2004', 569.99, '126', 6);

insert into Painting
values ('1341', 'Hasty Pudding Exit', '08/08/2004', 145.50, '123', null);

insert into Painting
values ('1342', 'Plastic Paradise', '06/18/2003', 8328.99, '126', 6);

insert into Painting
values ('1343', 'Roamin', '04/14/2005', 785.00, '127', 6);

insert into Painting
values ('1344', 'Wild Waters', '03/13/2005', 999.00, '127', 5);

insert into Painting
values ('1345', 'Stuff Such in Some', '03/25/2003', 9800.00, '123', 5);

commit;


-- ************************************************** QUERIES *****************************************************

-- a
select Painter.Firstname, Painter.Lastname
from Painter, Painting 
where Painter.Painter_No = Painting.Painter_No
    AND Gallery_No is null
    group by painter.Firstname, Painter.Lastname;


-- b
select Owner, cast(avg(Price) as decimal (12,2)) as AvgPrice
from Gallery, Painting
where Gallery.Gallery_No = Painting.Gallery_No 
group by Owner;


-- c
select Painting.Title, Painter.Firstname, Painter.Lastname
from Painting inner join Painter on Painter.Painter_No = Painting.Painter_No
where (to_char(Completion_Date, 'YYYY') = '2004')
    OR (to_char(Completion_Date, 'YYYY') = '2005');


-- d
select Title, Firstname, Lastname
from Painting inner join Painter on Painter.Painter_No = Painting.Painter_No
where Painting.Gallery_No IN
    (select Gallery_No from Gallery
    where Owner =  'G.G. Waters'
    AND ((to_char(Completion_Date, 'YYYY') = '2004')
    OR (to_char(Completion_Date, 'YYYY') = '2005')) );


-- e
select Owner, Title, Price
from Gallery full outer join Painting on Gallery.Gallery_No = Painting.Gallery_No;



