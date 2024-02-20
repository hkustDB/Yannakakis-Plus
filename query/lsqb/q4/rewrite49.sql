## AggReduce Phase: 

# AggReduce147
# 1. aggView
create or replace view aggView1475568887337234117 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2492279223275657150 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1475568887337234117 where Comment_replyOf_Message.ParentMessageId=aggView1475568887337234117.v1;

# AggReduce148
# 1. aggView
create or replace view aggView6609037753136246075 as select v1, SUM(annot) as annot from aggJoin2492279223275657150 group by v1;
# 2. aggJoin
create or replace view aggJoin5454650663880327850 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6609037753136246075 where Message_hasCreator_Person.MessageId=aggView6609037753136246075.v1;

# AggReduce149
# 1. aggView
create or replace view aggView9130134256902751761 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin3620392800612669456 as select aggJoin5454650663880327850.annot * aggView9130134256902751761.annot as annot from aggJoin5454650663880327850 join aggView9130134256902751761 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin3620392800612669456;

# drop view aggView1475568887337234117, aggJoin2492279223275657150, aggView6609037753136246075, aggJoin5454650663880327850, aggView9130134256902751761, aggJoin3620392800612669456;
