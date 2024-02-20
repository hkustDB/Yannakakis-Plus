## AggReduce Phase: 

# AggReduce9
# 1. aggView
create or replace view aggView4088806080615263653 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
# 2. aggJoin
create or replace view aggJoin7890110116121687641 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4088806080615263653 where Comment_replyOf_Message.CommentId=aggView4088806080615263653.v3;

# AggReduce10
# 1. aggView
create or replace view aggView9181105412610232841 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
# 2. aggJoin
create or replace view aggJoin7532494554903515104 as select MessageId as v1, TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView9181105412610232841 where Message_hasTag_Tag.TagId=aggView9181105412610232841.v2;

# AggReduce11
# 1. aggView
create or replace view aggView1687286623641056276 as select v1, SUM(annot) as annot, v2 from aggJoin7532494554903515104 group by v1,v2;
# 2. aggJoin
create or replace view aggJoin2451169397376502997 as select aggJoin7890110116121687641.annot * aggView1687286623641056276.annot as annot from aggJoin7890110116121687641 join aggView1687286623641056276 using(v1) where v2 < v8;
# Final result: 
select SUM(annot) as v9 from aggJoin2451169397376502997;

# drop view aggView4088806080615263653, aggJoin7890110116121687641, aggView9181105412610232841, aggJoin7532494554903515104, aggView1687286623641056276, aggJoin2451169397376502997;
