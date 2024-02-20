## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView3131263156023055458 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
# 2. aggJoin
create or replace view aggJoin3829104408259807940 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3131263156023055458 where Comment_replyOf_Message.CommentId=aggView3131263156023055458.v3;

# AggReduce1
# 1. aggView
create or replace view aggView2289299703998587021 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
# 2. aggJoin
create or replace view aggJoin3933282548476286240 as select aggJoin3829104408259807940.annot * aggView2289299703998587021.annot as annot from aggJoin3829104408259807940 join aggView2289299703998587021 using(v1) where v2 < v6;
# Final result: 
select SUM(annot) as v7 from aggJoin3933282548476286240;

# drop view aggView3131263156023055458, aggJoin3829104408259807940, aggView2289299703998587021, aggJoin3933282548476286240;
