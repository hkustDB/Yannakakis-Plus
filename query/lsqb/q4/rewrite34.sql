create or replace view aggView8970706547611643374 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7687925308205697167 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8970706547611643374 where Comment_replyOf_Message.ParentMessageId=aggView8970706547611643374.v1;
create or replace view aggView5140426806261586195 as select v1, SUM(annot) as annot from aggJoin7687925308205697167 group by v1;
create or replace view aggJoin1780837640278708031 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5140426806261586195 where Person_likes_Message.MessageId=aggView5140426806261586195.v1;
create or replace view aggView2815525886429356 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin4322939855707199061 as select aggJoin1780837640278708031.annot * aggView2815525886429356.annot as annot from aggJoin1780837640278708031 join aggView2815525886429356 using(v1);
select SUM(annot) as v9 from aggJoin4322939855707199061;
