create or replace view aggView7345321700520274514 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin51116062452477745 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7345321700520274514 where Message_hasCreator_Person.MessageId=aggView7345321700520274514.v1;
create or replace view aggView4125262233763982682 as select v1, SUM(annot) as annot from aggJoin51116062452477745 group by v1;
create or replace view aggJoin1131531999463737443 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4125262233763982682 where Comment_replyOf_Message.ParentMessageId=aggView4125262233763982682.v1;
create or replace view aggView1943104148967335869 as select v1, SUM(annot) as annot from aggJoin1131531999463737443 group by v1;
create or replace view aggJoin6873224728321872705 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1943104148967335869 where Message_hasTag_Tag.MessageId=aggView1943104148967335869.v1;
select SUM(annot) as v9 from aggJoin6873224728321872705;
