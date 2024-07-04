create or replace view aggView3282446291020129704 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
create or replace view aggJoin8062418460792310743 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3282446291020129704 where Comment_replyOf_Message.ParentMessageId=aggView3282446291020129704.v1;
create or replace view aggView4612795653722758387 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin6141169221352248910 as select v2, aggJoin8062418460792310743.annot * aggView4612795653722758387.annot as annot, v6 from aggJoin8062418460792310743 join aggView4612795653722758387 using(v3) where v2 < v6;
select SUM(annot) as v7 from aggJoin6141169221352248910;
