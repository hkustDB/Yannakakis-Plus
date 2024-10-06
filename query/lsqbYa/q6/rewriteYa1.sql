create or replace view semiUp6112085157572443739 as select Person1Id as v2, Person2Id as v5 from Person_knows_Person AS pkp2 where (Person2Id) in (select (PersonId) from Person_hasInterest_Tag AS Person_hasInterest_Tag);
create or replace view semiUp8396517398935736688 as select Person2Id as v2, Person1Id as pkp1_Id from Person_knows_Person AS pkp1 where (Person2Id) in (select (v2) from semiUp6112085157572443739);
create or replace view semiDown1084851124539746723 as select v2, v5 from semiUp6112085157572443739 where (v2) in (select (v2) from semiUp8396517398935736688);
create or replace view semiDown8433355379888021684 as select PersonId as v5 from Person_hasInterest_Tag AS Person_hasInterest_Tag where (PersonId) in (select (v5) from semiDown1084851124539746723);
create or replace view aggView1205694289420087428 as select v5, COUNT(*) as annot from semiDown8433355379888021684 group by v5;
create or replace view aggJoin898223571773016832 as select v2, v5, annot from semiDown1084851124539746723 join aggView1205694289420087428 using(v5);
create or replace view aggView223387051515342171 as select v2, v5, SUM(annot) as annot from aggJoin898223571773016832 group by v2, v5;
create or replace view aggJoin9191260249265105675 as select annot from semiUp8396517398935736688 join aggView223387051515342171 using(v2) where pkp1_Id < v5;
select SUM(annot) as v7 from aggJoin9191260249265105675;
