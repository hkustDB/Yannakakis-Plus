create or replace view aggView7389308285229328860 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin4142326863093277713 as select Person2Id as v4, v1, annot from Person_knows_Person as pkp2, aggView7389308285229328860 where pkp2.Person1Id=aggView7389308285229328860.v2 and v1<Person2Id;
create or replace view aggView5058627921920138468 as select v4, SUM(annot) as annot from aggJoin4142326863093277713 group by v4;
create or replace view aggJoin762541724202129209 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView5058627921920138468 where Person_hasInterest_Tag.PersonId=aggView5058627921920138468.v4;
create or replace view aggView7435365646844481156 as select v4, SUM(annot) as annot from aggJoin762541724202129209 group by v4;
create or replace view aggJoin728971198163962062 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView7435365646844481156 where pkp3.Person1Id=aggView7435365646844481156.v4;
select SUM(annot) as v9 from aggJoin728971198163962062;
