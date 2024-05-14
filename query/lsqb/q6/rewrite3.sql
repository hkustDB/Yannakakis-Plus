create or replace view aggView3889313385918194715 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin724760565275145298 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView3889313385918194715 where pkp2.Person2Id=aggView3889313385918194715.v5;
create or replace view aggView573235480048540946 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin7881150095179955507 as select v5, aggJoin724760565275145298.annot * aggView573235480048540946.annot as annot, v1 from aggJoin724760565275145298 join aggView573235480048540946 using(v2) where v1 < v5;
select SUM(annot) as v7 from aggJoin7881150095179955507;
