create or replace view aggView5397323674515403465 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin4937342438766151687 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView5397323674515403465 where pkp2.Person2Id=aggView5397323674515403465.v5;
create or replace view aggView416899342900474127 as select v2, SUM(annot) as annot, v5 from aggJoin4937342438766151687 group by v2,v5;
create or replace view aggJoin2209811561599678280 as select annot from Person_knows_Person as pkp1, aggView416899342900474127 where pkp1.Person2Id=aggView416899342900474127.v2 and Person1Id<v5;
select SUM(annot) as v7 from aggJoin2209811561599678280;
