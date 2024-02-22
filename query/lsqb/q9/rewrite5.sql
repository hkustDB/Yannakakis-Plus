create or replace view aggView4800036987016531241 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin3412546464408042555 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView4800036987016531241 where pkp3.Person1Id=aggView4800036987016531241.v4;
create or replace view aggView7322640831462066293 as select v4, SUM(annot) as annot from aggJoin3412546464408042555 group by v4;
create or replace view aggJoin1913027223022492413 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView7322640831462066293 where pkp2.Person2Id=aggView7322640831462066293.v4;
create or replace view aggView6010083068376253434 as select v2, SUM(annot) as annot, v4 from aggJoin1913027223022492413 group by v2,v4;
create or replace view aggJoin2116833511828106461 as select annot from Person_knows_Person as pkp1, aggView6010083068376253434 where pkp1.Person2Id=aggView6010083068376253434.v2 and Person1Id<v4;
select SUM(annot) as v9 from aggJoin2116833511828106461;
