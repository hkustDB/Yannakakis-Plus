## AggReduce Phase: 

# AggReduce27
# 1. aggView
create or replace view aggView1598096769180487552 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin5772410682660713879 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1598096769180487552 where Person_likes_Message.MessageId=aggView1598096769180487552.v1;

# AggReduce28
# 1. aggView
create or replace view aggView3780715561914341240 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5146246311630021162 as select v1, aggJoin5772410682660713879.annot * aggView3780715561914341240.annot as annot from aggJoin5772410682660713879 join aggView3780715561914341240 using(v1);

# AggReduce29
# 1. aggView
create or replace view aggView1523748828879585863 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6495212415962631702 as select aggJoin5146246311630021162.annot * aggView1523748828879585863.annot as annot from aggJoin5146246311630021162 join aggView1523748828879585863 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6495212415962631702;

# drop view aggView1598096769180487552, aggJoin5772410682660713879, aggView3780715561914341240, aggJoin5146246311630021162, aggView1523748828879585863, aggJoin6495212415962631702;
