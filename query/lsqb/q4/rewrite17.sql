## AggReduce Phase: 

# AggReduce51
# 1. aggView
create or replace view aggView5158253535479754850 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin5952701164014447549 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5158253535479754850 where Comment_replyOf_Message.ParentMessageId=aggView5158253535479754850.v1;

# AggReduce52
# 1. aggView
create or replace view aggView4145833481597040274 as select v1, SUM(annot) as annot from aggJoin5952701164014447549 group by v1;
# 2. aggJoin
create or replace view aggJoin8745275153846581565 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4145833481597040274 where Message_hasTag_Tag.MessageId=aggView4145833481597040274.v1;

# AggReduce53
# 1. aggView
create or replace view aggView1846602384918308046 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin6535903080201590495 as select aggJoin8745275153846581565.annot * aggView1846602384918308046.annot as annot from aggJoin8745275153846581565 join aggView1846602384918308046 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6535903080201590495;

# drop view aggView5158253535479754850, aggJoin5952701164014447549, aggView4145833481597040274, aggJoin8745275153846581565, aggView1846602384918308046, aggJoin6535903080201590495;
