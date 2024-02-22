create or replace view aggView5672621564416665014 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin1053588417266606912 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5672621564416665014 where Comment_replyOf_Message.ParentMessageId=aggView5672621564416665014.v1;
create or replace view aggView7713043197178383937 as select v1, SUM(annot) as annot from aggJoin1053588417266606912 group by v1;
create or replace view aggJoin1983577626058343250 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7713043197178383937 where Message_hasTag_Tag.MessageId=aggView7713043197178383937.v1;
create or replace view aggView8810137335041250184 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin557329836120559276 as select aggJoin1983577626058343250.annot * aggView8810137335041250184.annot as annot from aggJoin1983577626058343250 join aggView8810137335041250184 using(v1);
select SUM(annot) as v9 from aggJoin557329836120559276;
