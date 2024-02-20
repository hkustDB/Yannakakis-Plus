## AggReduce Phase: 

# AggReduce69
# 1. aggView
create or replace view aggView5302744820604072119 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin786271604661937587 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5302744820604072119 where Comment_replyOf_Message.ParentMessageId=aggView5302744820604072119.v1;

# AggReduce70
# 1. aggView
create or replace view aggView6356138613916428085 as select v1, SUM(annot) as annot from aggJoin786271604661937587 group by v1;
# 2. aggJoin
create or replace view aggJoin8720792609983599345 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6356138613916428085 where Message_hasTag_Tag.MessageId=aggView6356138613916428085.v1;

# AggReduce71
# 1. aggView
create or replace view aggView751337582475666595 as select v1, SUM(annot) as annot from aggJoin8720792609983599345 group by v1;
# 2. aggJoin
create or replace view aggJoin8707649671909415963 as select annot from Person_likes_Message as Person_likes_Message, aggView751337582475666595 where Person_likes_Message.MessageId=aggView751337582475666595.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8707649671909415963;

# drop view aggView5302744820604072119, aggJoin786271604661937587, aggView6356138613916428085, aggJoin8720792609983599345, aggView751337582475666595, aggJoin8707649671909415963;
