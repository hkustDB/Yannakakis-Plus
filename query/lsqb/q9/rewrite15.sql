create or replace view aggView869498371598880352 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin5299941124457250533 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView869498371598880352 where Person_hasInterest_Tag.PersonId=aggView869498371598880352.v4;
create or replace view aggView7606644601593480124 as select v4, SUM(annot) as annot from aggJoin5299941124457250533 group by v4;
create or replace view aggJoin7597839256416263322 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView7606644601593480124 where pkp2.Person2Id=aggView7606644601593480124.v4;
create or replace view aggView2759465291249601005 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin4448852226417727090 as select aggJoin7597839256416263322.annot * aggView2759465291249601005.annot as annot from aggJoin7597839256416263322 join aggView2759465291249601005 using(v2) where v1 < v4;
select SUM(annot) as v9 from aggJoin4448852226417727090;
