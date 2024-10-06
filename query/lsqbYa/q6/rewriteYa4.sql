create or replace view semiUp3586002809485631830 as select Person1Id as v2, Person2Id as v5 from Person_knows_Person AS pkp2 where (Person1Id) in (select (Person2Id) from Person_knows_Person AS pkp1);
create or replace view semiUp7777476187706715425 as select v2, v5 from semiUp3586002809485631830 where (v5) in (select (PersonId) from Person_hasInterest_Tag AS Person_hasInterest_Tag);
create or replace view semiDown4476137768197088638 as select PersonId as v5 from Person_hasInterest_Tag AS Person_hasInterest_Tag where (PersonId) in (select (v5) from semiUp7777476187706715425);
create or replace view semiDown5497352661204509590 as select Person2Id as v2, Person1Id as pkp1_Id from Person_knows_Person AS pkp1 where (Person2Id) in (select (v2) from semiUp7777476187706715425);
create or replace view aggView3092019210205259302 as select v2, pkp1_Id, COUNT(*) as annot from semiDown5497352661204509590 group by v2, pkp1_Id;
create or replace view aggJoin2602959201457462328 as select v5, annot from semiUp7777476187706715425 join aggView3092019210205259302 using(v2) where pkp1_Id < v5;
create or replace view aggView7725090206405935036 as select v5, COUNT(*) as annot from semiDown4476137768197088638 group by v5;
create or replace view aggJoin6980916697976250721 as select aggJoin2602959201457462328.annot * aggView7725090206405935036.annot as annot from aggJoin2602959201457462328 join aggView7725090206405935036 using(v5);
select SUM(annot) as v7 from aggJoin6980916697976250721;
