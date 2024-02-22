create or replace view aggView527294996877174996 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5904495550814321586 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView527294996877174996 where Person_likes_Message.MessageId=aggView527294996877174996.v1;
create or replace view aggView454661014355807206 as select v1, SUM(annot) as annot from aggJoin5904495550814321586 group by v1;
create or replace view aggJoin6120431497533470559 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView454661014355807206 where Comment_replyOf_Message.ParentMessageId=aggView454661014355807206.v1;
create or replace view aggView9133782556838262474 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2034600523232062096 as select aggJoin6120431497533470559.annot * aggView9133782556838262474.annot as annot from aggJoin6120431497533470559 join aggView9133782556838262474 using(v1);
select SUM(annot) as v9 from aggJoin2034600523232062096;
