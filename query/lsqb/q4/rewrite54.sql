## AggReduce Phase: 

# AggReduce162
# 1. aggView
create or replace view aggView8854335245918763727 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6654258854400582634 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8854335245918763727 where Message_hasTag_Tag.MessageId=aggView8854335245918763727.v1;

# AggReduce163
# 1. aggView
create or replace view aggView932508469356744403 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin7771046930093369580 as select v1, aggJoin6654258854400582634.annot * aggView932508469356744403.annot as annot from aggJoin6654258854400582634 join aggView932508469356744403 using(v1);

# AggReduce164
# 1. aggView
create or replace view aggView9161273516100873250 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4669598658948315109 as select aggJoin7771046930093369580.annot * aggView9161273516100873250.annot as annot from aggJoin7771046930093369580 join aggView9161273516100873250 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4669598658948315109;

# drop view aggView8854335245918763727, aggJoin6654258854400582634, aggView932508469356744403, aggJoin7771046930093369580, aggView9161273516100873250, aggJoin4669598658948315109;
