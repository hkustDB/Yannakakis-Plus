## AggReduce Phase: 

# AggReduce2
# 1. aggView
create or replace view aggView8205684357471094950 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
# 2. aggJoin
create or replace view aggJoin1992534651983148584 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8205684357471094950 where Comment_replyOf_Message.CommentId=aggView8205684357471094950.v3;

# AggReduce3
# 1. aggView
create or replace view aggView6308165217983928458 as select v1, SUM(annot) as annot, v6 from aggJoin1992534651983148584 group by v1,v6;
# 2. aggJoin
create or replace view aggJoin7594733726398537041 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6308165217983928458 where Message_hasTag_Tag.MessageId=aggView6308165217983928458.v1 and TagId<v6;
# Final result: 
select SUM(annot) as v7 from aggJoin7594733726398537041;

# drop view aggView8205684357471094950, aggJoin1992534651983148584, aggView6308165217983928458, aggJoin7594733726398537041;
