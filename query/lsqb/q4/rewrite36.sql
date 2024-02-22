create or replace view aggView3040300126301089605 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2948333586389847444 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3040300126301089605 where Comment_replyOf_Message.ParentMessageId=aggView3040300126301089605.v1;
create or replace view aggView1295636303871368781 as select v1, SUM(annot) as annot from aggJoin2948333586389847444 group by v1;
create or replace view aggJoin8587648742906457146 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1295636303871368781 where Person_likes_Message.MessageId=aggView1295636303871368781.v1;
create or replace view aggView4842166049760468 as select v1, SUM(annot) as annot from aggJoin8587648742906457146 group by v1;
create or replace view aggJoin5569221122739824310 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4842166049760468 where Message_hasTag_Tag.MessageId=aggView4842166049760468.v1;
select SUM(annot) as v9 from aggJoin5569221122739824310;
