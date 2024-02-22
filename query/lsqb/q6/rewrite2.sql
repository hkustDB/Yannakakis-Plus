create or replace view aggView5950770229275727095 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin5553072588250286451 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView5950770229275727095 where pkp2.Person2Id=aggView5950770229275727095.v5;
create or replace view aggView3143288937460932704 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin2038134757131639344 as select aggJoin5553072588250286451.annot * aggView3143288937460932704.annot as annot from aggJoin5553072588250286451 join aggView3143288937460932704 using(v2) where v1 < v5;
select SUM(annot) as v7 from aggJoin2038134757131639344;
