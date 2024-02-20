## AggReduce Phase: 

# AggReduce105
# 1. aggView
create or replace view aggView8364565461731435626 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin4875474996662510362 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8364565461731435626 where Comment_replyOf_Message.ParentMessageId=aggView8364565461731435626.v1;

# AggReduce106
# 1. aggView
create or replace view aggView102492944618457899 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5993488703598423 as select v1, aggJoin4875474996662510362.annot * aggView102492944618457899.annot as annot from aggJoin4875474996662510362 join aggView102492944618457899 using(v1);

# AggReduce107
# 1. aggView
create or replace view aggView5561360826632170365 as select v1, SUM(annot) as annot from aggJoin5993488703598423 group by v1;
# 2. aggJoin
create or replace view aggJoin8807913905772011545 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5561360826632170365 where Message_hasTag_Tag.MessageId=aggView5561360826632170365.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8807913905772011545;

# drop view aggView8364565461731435626, aggJoin4875474996662510362, aggView102492944618457899, aggJoin5993488703598423, aggView5561360826632170365, aggJoin8807913905772011545;
