## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6568195983638044950 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6531649075069222379 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6568195983638044950 where Message_hasCreator_Person.MessageId=aggView6568195983638044950.v1;

# AggReduce1
# 1. aggView
create or replace view aggView1463358873357301740 as select v1, SUM(annot) as annot from aggJoin6531649075069222379 group by v1;
# 2. aggJoin
create or replace view aggJoin6686765659386381220 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1463358873357301740 where Person_likes_Message.MessageId=aggView1463358873357301740.v1;

# AggReduce2
# 1. aggView
create or replace view aggView9066191827047734093 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4237486125752955237 as select aggJoin6686765659386381220.annot * aggView9066191827047734093.annot as annot from aggJoin6686765659386381220 join aggView9066191827047734093 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4237486125752955237;

# drop view aggView6568195983638044950, aggJoin6531649075069222379, aggView1463358873357301740, aggJoin6686765659386381220, aggView9066191827047734093, aggJoin4237486125752955237;
