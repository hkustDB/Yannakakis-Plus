## AggReduce Phase: 

# AggReduce87
# 1. aggView
create or replace view aggView2264064908848669503 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6645971436210986535 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2264064908848669503 where Message_hasCreator_Person.MessageId=aggView2264064908848669503.v1;

# AggReduce88
# 1. aggView
create or replace view aggView1813585362519891209 as select v1, SUM(annot) as annot from aggJoin6645971436210986535 group by v1;
# 2. aggJoin
create or replace view aggJoin1004536760998935332 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1813585362519891209 where Comment_replyOf_Message.ParentMessageId=aggView1813585362519891209.v1;

# AggReduce89
# 1. aggView
create or replace view aggView3487639264100534825 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4291789004053435615 as select aggJoin1004536760998935332.annot * aggView3487639264100534825.annot as annot from aggJoin1004536760998935332 join aggView3487639264100534825 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4291789004053435615;

# drop view aggView2264064908848669503, aggJoin6645971436210986535, aggView1813585362519891209, aggJoin1004536760998935332, aggView3487639264100534825, aggJoin4291789004053435615;
