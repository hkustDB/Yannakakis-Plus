create or replace view aggView1933844086507398006 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
create or replace view aggJoin4694222004237056354 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1933844086507398006 where Comment_replyOf_Message.ParentMessageId=aggView1933844086507398006.v1;
create or replace view aggView3862391751659447783 as select v3, SUM(annot) as annot, v2 from aggJoin4694222004237056354 group by v3,v2;
create or replace view aggJoin2162490357014135565 as select annot from Comment_hasTag_Tag as cht, aggView3862391751659447783 where cht.CommentId=aggView3862391751659447783.v3 and v2<TagId;
select SUM(annot) as v7 from aggJoin2162490357014135565;
