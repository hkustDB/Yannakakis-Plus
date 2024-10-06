create or replace view semiUp3465065769225716050 as select Person1Id as v2, Person2Id as v5 from Person_knows_Person AS pkp2 where (Person1Id) in (select (Person2Id) from Person_knows_Person AS pkp1);
create or replace view semiUp4883947908038178053 as select PersonId as v5 from Person_hasInterest_Tag AS Person_hasInterest_Tag where (PersonId) in (select (v5) from semiUp3465065769225716050);
create or replace view semiDown1145004732428862293 as select v2, v5 from semiUp3465065769225716050 where (v5) in (select (v5) from semiUp4883947908038178053);
create or replace view semiDown6568105221438685299 as select Person1Id as pkp1_Id, Person2Id as v2 from Person_knows_Person AS pkp1 where (Person2Id) in (select (v2) from semiDown1145004732428862293);
create or replace view aggView8690633673083433831 as select v2, pkp1_Id, COUNT(*) as annot from semiDown6568105221438685299 group by v2, pkp1_Id;
create or replace view aggJoin291159289392555105 as select v5, annot from semiDown1145004732428862293 join aggView8690633673083433831 using(v2) where pkp1_Id < v5;
create or replace view aggView3106504472935492941 as select v5, SUM(annot) as annot from aggJoin291159289392555105 group by v5;
create or replace view aggJoin2243117376194703062 as select annot from semiUp4883947908038178053 join aggView3106504472935492941 using(v5);
select SUM(annot) as v7 from aggJoin2243117376194703062;
