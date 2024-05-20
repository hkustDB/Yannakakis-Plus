create or replace view aggView2528301913914025458 as select hasCreator_PersonId as v2, PostId as v6 from Post as Post;
create or replace view aggJoin8401722610535987687 as select Person1Id as v1, v6 from Person_knows_Person as Person_knows_Person, aggView2528301913914025458 where Person_knows_Person.Person2Id=aggView2528301913914025458.v2;
create or replace view aggView3073504201954357492 as select v1, v6, COUNT(*) as annot from aggJoin8401722610535987687 group by v1,v6;
create or replace view aggJoin1279770645330624710 as select replyOf_PostId as v6, annot from Comment as Comment, aggView3073504201954357492 where Comment.hasCreator_PersonId=aggView3073504201954357492.v1 and Comment.replyOf_PostId=aggView3073504201954357492.v6;
select SUM(annot) as v12 from aggJoin1279770645330624710;
