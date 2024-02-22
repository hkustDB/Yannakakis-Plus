create or replace view aggView4333618024685574048 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin3074692063501621833 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView4333618024685574048 where Person_hasInterest_Tag.PersonId=aggView4333618024685574048.v4;
create or replace view aggView2050797865402031430 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin4664571736218669769 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView2050797865402031430 where pkp2.Person1Id=aggView2050797865402031430.v2 and v1<Person2Id;
create or replace view aggView7637141473133174865 as select v4, SUM(annot) as annot from aggJoin4664571736218669769 group by v4;
create or replace view aggJoin1431330135145709164 as select aggJoin3074692063501621833.annot * aggView7637141473133174865.annot as annot from aggJoin3074692063501621833 join aggView7637141473133174865 using(v4);
select SUM(annot) as v9 from aggJoin1431330135145709164;
