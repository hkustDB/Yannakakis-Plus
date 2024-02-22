create or replace view aggView8959429790783012358 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin69052707441830707 as select Person2Id as v5, annot from Person_knows_Person as pkp2, aggView8959429790783012358 where pkp2.Person1Id=aggView8959429790783012358.v2 and v1<Person2Id;
create or replace view aggView4480844682643900154 as select v5, SUM(annot) as annot from aggJoin69052707441830707 group by v5;
create or replace view aggJoin6803643870337788840 as select annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView4480844682643900154 where Person_hasInterest_Tag.PersonId=aggView4480844682643900154.v5;
select SUM(annot) as v7 from aggJoin6803643870337788840;
