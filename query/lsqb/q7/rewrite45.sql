create or replace view aggView7443117712909574453 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6621576813733064494 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7443117712909574453 where Comment_replyOf_Message.ParentMessageId=aggView7443117712909574453.v1;
create or replace view aggView7698639335314549506 as select v1, SUM(annot) as annot from aggJoin6621576813733064494 group by v1;
create or replace view aggJoin8484570786274561368 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7698639335314549506 where Person_likes_Message.MessageId=aggView7698639335314549506.v1;
create or replace view aggView8235919185015098497 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5905068411386995016 as select aggJoin8484570786274561368.annot * aggView8235919185015098497.annot as annot from aggJoin8484570786274561368 join aggView8235919185015098497 using(v1);
select SUM(annot) as v9 from aggJoin5905068411386995016;
