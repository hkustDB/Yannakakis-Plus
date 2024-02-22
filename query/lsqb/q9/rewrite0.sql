create or replace view aggView8668685012044307868 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin294238982875392116 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView8668685012044307868 where Person_hasInterest_Tag.PersonId=aggView8668685012044307868.v4;
create or replace view aggView5141798680040231918 as select v4, SUM(annot) as annot from aggJoin294238982875392116 group by v4;
create or replace view aggJoin8810649797740017883 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView5141798680040231918 where pkp2.Person2Id=aggView5141798680040231918.v4;
create or replace view aggView1813964134935382266 as select v2, SUM(annot) as annot, v4 from aggJoin8810649797740017883 group by v2,v4;
create or replace view aggJoin3142851322859221166 as select annot from Person_knows_Person as pkp1, aggView1813964134935382266 where pkp1.Person2Id=aggView1813964134935382266.v2 and Person1Id<v4;
select SUM(annot) as v9 from aggJoin3142851322859221166;
