create or replace view aggView1006932116680990873 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin4227147181922550345 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView1006932116680990873 where Person_hasInterest_Tag.PersonId=aggView1006932116680990873.v4;
create or replace view aggView4536411889251290272 as select v4, SUM(annot) as annot from aggJoin4227147181922550345 group by v4;
create or replace view aggJoin4594590930815275007 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4536411889251290272 where pkp2.Person2Id=aggView4536411889251290272.v4;
create or replace view aggView1910461493920049876 as select v2, SUM(annot) as annot, v4 from aggJoin4594590930815275007 group by v2,v4;
create or replace view aggJoin7022825826907219443 as select Person1Id as v1, v4, annot from Person_knows_Person as pkp1, aggView1910461493920049876 where pkp1.Person2Id=aggView1910461493920049876.v2 and Person1Id<v4;
select SUM(annot) as v9 from aggJoin7022825826907219443;
