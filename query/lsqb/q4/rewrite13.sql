create or replace view aggView318183803738546442 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin1392420162041023270 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView318183803738546442 where Message_hasTag_Tag.MessageId=aggView318183803738546442.v1;
create or replace view aggView9041906090516046970 as select v1, SUM(annot) as annot from aggJoin1392420162041023270 group by v1;
create or replace view aggJoin2498043314772716082 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView9041906090516046970 where Person_likes_Message.MessageId=aggView9041906090516046970.v1;
create or replace view aggView8323323833627744756 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin1920316163792051422 as select aggJoin2498043314772716082.annot * aggView8323323833627744756.annot as annot from aggJoin2498043314772716082 join aggView8323323833627744756 using(v1);
select SUM(annot) as v9 from aggJoin1920316163792051422;
