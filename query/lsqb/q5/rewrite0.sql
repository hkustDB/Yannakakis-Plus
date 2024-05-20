create or replace view aggView1265280999381218525 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
create or replace view aggJoin7088370141002342232 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1265280999381218525 where Comment_replyOf_Message.ParentMessageId=aggView1265280999381218525.v1;
create or replace view aggView6137422278504846137 as select v3, SUM(annot) as annot, v2 from aggJoin7088370141002342232 group by v3,v2;
create or replace view aggJoin5258250672419084228 as select TagId as v6, v2, annot from Comment_hasTag_Tag as cht, aggView6137422278504846137 where cht.CommentId=aggView6137422278504846137.v3 and v2<TagId;
select SUM(annot) as v7 from aggJoin5258250672419084228;
