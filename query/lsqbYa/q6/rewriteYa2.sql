create or replace view semiUp4554903451441393157 as select Person1Id as v2, Person2Id as v5 from Person_knows_Person AS pkp2 where (Person2Id) in (select (PersonId) from Person_hasInterest_Tag AS Person_hasInterest_Tag);
create or replace view semiUp7554296426628339614 as select Person2Id as v2, Person1Id as pkp1_Id from Person_knows_Person AS pkp1 where (Person2Id) in (select (v2) from semiUp4554903451441393157);
create or replace view semiDown536989916867830713 as select v2, v5 from semiUp4554903451441393157 where (v2) in (select (v2) from semiUp7554296426628339614);
create or replace view semiDown6893426993039181428 as select PersonId as v5 from Person_hasInterest_Tag AS Person_hasInterest_Tag where (PersonId) in (select (v5) from semiDown536989916867830713);
create or replace view aggView1627487346767997690 as select v5, COUNT(*) as annot from semiDown6893426993039181428 group by v5;
create or replace view aggJoin4899528464582033828 as select v2, v5, annot from semiDown536989916867830713 join aggView1627487346767997690 using(v5);
create or replace view aggView2519500522529617678 as select v2, v5, SUM(annot) as annot from aggJoin4899528464582033828 group by v2, v5;
create or replace view aggJoin4087435053628260101 as select annot from semiUp7554296426628339614 join aggView2519500522529617678 using(v2) where pkp1_Id < v5;
select SUM(annot) as v7 from aggJoin4087435053628260101;
