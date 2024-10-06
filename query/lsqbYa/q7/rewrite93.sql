create or replace view aggView3770537071490907138 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5107552547457351372 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3770537071490907138 where Message_hasCreator_Person.MessageId=aggView3770537071490907138.v1;
create or replace view aggView7655020075417369815 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6970471737294464730 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7655020075417369815 where Message_hasTag_Tag.MessageId=aggView7655020075417369815.v1;
create or replace view aggView6582841529774277298 as select v1, SUM(annot) as annot from aggJoin6970471737294464730 group by v1;
create or replace view aggJoin3970675062282786665 as select aggJoin5107552547457351372.annot * aggView6582841529774277298.annot as annot from aggJoin5107552547457351372 join aggView6582841529774277298 using(v1);
select SUM(annot) as v9 from aggJoin3970675062282786665;
