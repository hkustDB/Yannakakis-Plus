## AggReduce Phase: 

# AggReduce180
# 1. aggView
create or replace view aggView3727708196977640125 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4580872658357588138 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3727708196977640125 where Comment_replyOf_Message.ParentMessageId=aggView3727708196977640125.v1;

# AggReduce181
# 1. aggView
create or replace view aggView6219773005188362827 as select v1, SUM(annot) as annot from aggJoin4580872658357588138 group by v1;
# 2. aggJoin
create or replace view aggJoin1001300242989304240 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6219773005188362827 where Message_hasCreator_Person.MessageId=aggView6219773005188362827.v1;

# AggReduce182
# 1. aggView
create or replace view aggView2821010360143062920 as select v1, SUM(annot) as annot from aggJoin1001300242989304240 group by v1;
# 2. aggJoin
create or replace view aggJoin5440246311972392741 as select annot from Person_likes_Message as Person_likes_Message, aggView2821010360143062920 where Person_likes_Message.MessageId=aggView2821010360143062920.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5440246311972392741;

# drop view aggView3727708196977640125, aggJoin4580872658357588138, aggView6219773005188362827, aggJoin1001300242989304240, aggView2821010360143062920, aggJoin5440246311972392741;
