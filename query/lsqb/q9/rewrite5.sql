create or replace view aggView5375143498911202628 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin1553391388158585567 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView5375143498911202628 where Person_hasInterest_Tag.PersonId=aggView5375143498911202628.v4;
create or replace view aggView2133560338202763261 as select v4, SUM(annot) as annot from aggJoin1553391388158585567 group by v4;
create or replace view aggJoin4231838584419541392 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView2133560338202763261 where pkp2.Person2Id=aggView2133560338202763261.v4;
create or replace view aggView3070036466693199368 as select v2, SUM(annot) as annot, v4 from aggJoin4231838584419541392 group by v2,v4;
create or replace view aggJoin7678774198222118537 as select annot from Person_knows_Person as pkp1, aggView3070036466693199368 where pkp1.Person2Id=aggView3070036466693199368.v2 and Person1Id<v4;
select SUM(annot) as v9 from aggJoin7678774198222118537;
