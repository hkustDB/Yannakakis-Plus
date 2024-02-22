create or replace view aggView8764106712105432355 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3534417816730172173 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8764106712105432355 where Comment_replyOf_Message.ParentMessageId=aggView8764106712105432355.v1;
create or replace view aggView4088831347447499983 as select v1, SUM(annot) as annot from aggJoin3534417816730172173 group by v1;
create or replace view aggJoin5408941159710563491 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4088831347447499983 where Person_likes_Message.MessageId=aggView4088831347447499983.v1;
create or replace view aggView3414840267831987516 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin4601506892001729000 as select aggJoin5408941159710563491.annot * aggView3414840267831987516.annot as annot from aggJoin5408941159710563491 join aggView3414840267831987516 using(v1);
select SUM(annot) as v9 from aggJoin4601506892001729000;
