create or replace view aggView415152324768114830 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin9038489048548192579 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView415152324768114830 where pkp2.Person2Id=aggView415152324768114830.v4;
create or replace view aggView1993069297484960664 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin1887982343766773564 as select v2, v4, aggJoin9038489048548192579.annot * aggView1993069297484960664.annot as annot from aggJoin9038489048548192579 join aggView1993069297484960664 using(v4);
create or replace view aggView2305949180074566602 as select v2, SUM(annot) as annot, v4 from aggJoin1887982343766773564 group by v2,v4;
create or replace view aggJoin112043847045518377 as select annot from Person_knows_Person as pkp1, aggView2305949180074566602 where pkp1.Person2Id=aggView2305949180074566602.v2 and Person1Id<v4;
select SUM(annot) as v9 from aggJoin112043847045518377;
