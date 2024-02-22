create or replace view aggView3995868430687814950 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1868963219042861730 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3995868430687814950 where Message_hasCreator_Person.MessageId=aggView3995868430687814950.v1;
create or replace view aggView242553706271895914 as select v1, SUM(annot) as annot from aggJoin1868963219042861730 group by v1;
create or replace view aggJoin5180692471268052384 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView242553706271895914 where Person_likes_Message.MessageId=aggView242553706271895914.v1;
create or replace view aggView8548039595670421999 as select v1, SUM(annot) as annot from aggJoin5180692471268052384 group by v1;
create or replace view aggJoin3394073666309568800 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8548039595670421999 where Comment_replyOf_Message.ParentMessageId=aggView8548039595670421999.v1;
select SUM(annot) as v9 from aggJoin3394073666309568800;
