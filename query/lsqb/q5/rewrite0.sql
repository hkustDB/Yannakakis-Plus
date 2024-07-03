create or replace view aggJoin7088370141002342232 as select CommentId as v3, TagId as v2 from Comment_replyOf_Message as Comment_replyOf_Message, Message_hasTag_Tag where Comment_replyOf_Message.ParentMessageId=Message_hasTag_Tag.MessageId;
create or replace view aggView6137422278504846137 as select v3, COUNT(*) as annot, v2 from aggJoin7088370141002342232 group by v3,v2;
select SUM(annot) from Comment_hasTag_Tag as cht, aggView6137422278504846137 where cht.CommentId=aggView6137422278504846137.v3 and v2<TagId;
