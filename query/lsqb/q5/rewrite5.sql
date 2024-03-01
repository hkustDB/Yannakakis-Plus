create or replace view aggView4084321009885304162 as select CommentId as v3, TagId as v6 from Comment_hasTag_Tag as cht;
create or replace view aggJoin5602739786830269011 as select ParentMessageId as v1, v6 from Comment_replyOf_Message as Comment_replyOf_Message, aggView4084321009885304162 where Comment_replyOf_Message.CommentId=aggView4084321009885304162.v3;
select count(*) from aggJoin5602739786830269011, Message_hasTag_Tag where v1=MessageId and TagId < v6;
