create or replace view aggView2450766801852027563 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin8664379409813890852 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2450766801852027563 where Message_hasTag_Tag.MessageId=aggView2450766801852027563.v1;
create or replace view aggView391587377060056795 as select v1, SUM(annot) as annot from aggJoin8664379409813890852 group by v1;
create or replace view aggJoin4424164853589122918 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView391587377060056795 where Person_likes_Message.MessageId=aggView391587377060056795.v1;
create or replace view aggView8170745721795571737 as select v1, SUM(annot) as annot from aggJoin4424164853589122918 group by v1;
create or replace view aggJoin7970775980414267188 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8170745721795571737 where Comment_replyOf_Message.ParentMessageId=aggView8170745721795571737.v1;
select SUM(annot) as v9 from aggJoin7970775980414267188;
