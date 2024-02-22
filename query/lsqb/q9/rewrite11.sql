create or replace view aggView3493005461401128218 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin8965856267111768462 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView3493005461401128218 where pkp2.Person2Id=aggView3493005461401128218.v4;
create or replace view aggView2261375405249774874 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin4515066961307738288 as select v4, aggJoin8965856267111768462.annot * aggView2261375405249774874.annot as annot from aggJoin8965856267111768462 join aggView2261375405249774874 using(v2) where v1 < v4;
create or replace view aggView111837223242916620 as select v4, SUM(annot) as annot from aggJoin4515066961307738288 group by v4;
create or replace view aggJoin1818634170347755823 as select annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView111837223242916620 where Person_hasInterest_Tag.PersonId=aggView111837223242916620.v4;
select SUM(annot) as v9 from aggJoin1818634170347755823;
