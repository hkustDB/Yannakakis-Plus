create or replace view aggView1265280999381218525 as select MessageId as v1, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag;
create or replace view aggJoin7088370141002342232 as select CommentId as v3, v2 from Comment_replyOf_Message as Comment_replyOf_Message, aggView1265280999381218525 where Comment_replyOf_Message.ParentMessageId=aggView1265280999381218525.v1;
create or replace view aggView6137422278504846137 as select v3, v2 from aggJoin7088370141002342232;
select COUNT(*) from Comment_hasTag_Tag as cht, aggView6137422278504846137 where cht.CommentId=aggView6137422278504846137.v3 and v2<TagId;
