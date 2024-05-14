create or replace view aggView4775703041730391663 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin1660620611242961619 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4775703041730391663 where Comment_replyOf_Message.CommentId=aggView4775703041730391663.v3;
create or replace view aggView1347216764009875171 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
create or replace view aggJoin6819868703129465985 as select v6, aggJoin1660620611242961619.annot * aggView1347216764009875171.annot as annot, v2 from aggJoin1660620611242961619 join aggView1347216764009875171 using(v1) where v2 < v6;
select SUM(annot) as v7 from aggJoin6819868703129465985;
