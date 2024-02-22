create or replace view aggView6234877509898266400 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3496435468077941571 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6234877509898266400 where Message_hasTag_Tag.MessageId=aggView6234877509898266400.v1;
create or replace view aggView6432856731241485566 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5977134641673751723 as select v1, aggJoin3496435468077941571.annot * aggView6432856731241485566.annot as annot from aggJoin3496435468077941571 join aggView6432856731241485566 using(v1);
create or replace view aggView6945347652405831437 as select v1, SUM(annot) as annot from aggJoin5977134641673751723 group by v1;
create or replace view aggJoin3169573484663501435 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6945347652405831437 where Message_hasCreator_Person.MessageId=aggView6945347652405831437.v1;
select SUM(annot) as v9 from aggJoin3169573484663501435;
