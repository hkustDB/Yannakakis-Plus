create or replace view aggView8101601704979825783 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin6521200549350804690 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView8101601704979825783 where pkp2.Person1Id=aggView8101601704979825783.v2 and v1<Person2Id;
create or replace view aggView1415953854090897490 as select v4, SUM(annot) as annot from aggJoin6521200549350804690 group by v4;
create or replace view aggJoin7303219214269865492 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView1415953854090897490 where Person_hasInterest_Tag.PersonId=aggView1415953854090897490.v4;
create or replace view aggView3676477064829590356 as select v4, SUM(annot) as annot from aggJoin7303219214269865492 group by v4;
create or replace view aggJoin1694145088197624219 as select annot from Person_knows_Person as pkp3, aggView3676477064829590356 where pkp3.Person1Id=aggView3676477064829590356.v4;
select SUM(annot) as v9 from aggJoin1694145088197624219;
