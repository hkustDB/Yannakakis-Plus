create or replace view aggView4648990325429128024 as select hasCreator_PersonId as v2, PostId as v6, COUNT(*) as annot from Post as Post group by hasCreator_PersonId,PostId;
create or replace view aggJoin2746541343916527223 as select Person1Id as v1, v6, annot from Person_knows_Person as Person_knows_Person, aggView4648990325429128024 where Person_knows_Person.Person2Id=aggView4648990325429128024.v2;
create or replace view aggView6808039652292563261 as select v1, v6, SUM(annot) as annot from aggJoin2746541343916527223 group by v1,v6;
create or replace view aggJoin2667003820041932120 as select replyOf_PostId as v6, annot from Comment as Comment, aggView6808039652292563261 where Comment.hasCreator_PersonId=aggView6808039652292563261.v1 and Comment.replyOf_PostId=aggView6808039652292563261.v6;
select SUM(annot) as v12 from aggJoin2667003820041932120;
