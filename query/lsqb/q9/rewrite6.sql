create or replace view aggView945955862605510361 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin7586778737545608745 as select Person2Id as v4, v1, annot from Person_knows_Person as pkp2, aggView945955862605510361 where pkp2.Person1Id=aggView945955862605510361.v2 and v1<Person2Id;
create or replace view aggView3038369101024289844 as select v4, SUM(annot) as annot from aggJoin7586778737545608745 group by v4;
create or replace view aggJoin9033278165391086883 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView3038369101024289844 where Person_hasInterest_Tag.PersonId=aggView3038369101024289844.v4;
create or replace view aggView5795192929819944920 as select v4, SUM(annot) as annot from aggJoin9033278165391086883 group by v4;
create or replace view aggJoin3591737455807970705 as select annot from Person_knows_Person as pkp3, aggView5795192929819944920 where pkp3.Person1Id=aggView5795192929819944920.v4;
select SUM(annot) as v9 from aggJoin3591737455807970705;
