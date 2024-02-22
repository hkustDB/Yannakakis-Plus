create or replace view aggView4460045747603506855 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin588312654791064819 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4460045747603506855 where pkp2.Person1Id=aggView4460045747603506855.v2 and v1<Person2Id;
create or replace view aggView8329866391900138128 as select v4, SUM(annot) as annot from aggJoin588312654791064819 group by v4;
create or replace view aggJoin2945254354433883930 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView8329866391900138128 where pkp3.Person1Id=aggView8329866391900138128.v4;
create or replace view aggView2991373381874646841 as select v4, SUM(annot) as annot from aggJoin2945254354433883930 group by v4;
create or replace view aggJoin6182789186697328794 as select annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView2991373381874646841 where Person_hasInterest_Tag.PersonId=aggView2991373381874646841.v4;
select SUM(annot) as v9 from aggJoin6182789186697328794;
