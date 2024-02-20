## AggReduce Phase: 

# AggReduce159
# 1. aggView
create or replace view aggView1469093998102635656 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin2199813788959086490 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1469093998102635656 where Message_hasCreator_Person.MessageId=aggView1469093998102635656.v1;

# AggReduce160
# 1. aggView
create or replace view aggView9180930289715496097 as select v1, SUM(annot) as annot from aggJoin2199813788959086490 group by v1;
# 2. aggJoin
create or replace view aggJoin1067414819359532036 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView9180930289715496097 where Comment_replyOf_Message.ParentMessageId=aggView9180930289715496097.v1;

# AggReduce161
# 1. aggView
create or replace view aggView3674393073357760174 as select v1, SUM(annot) as annot from aggJoin1067414819359532036 group by v1;
# 2. aggJoin
create or replace view aggJoin2722772214147057024 as select annot from Person_likes_Message as Person_likes_Message, aggView3674393073357760174 where Person_likes_Message.MessageId=aggView3674393073357760174.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2722772214147057024;

# drop view aggView1469093998102635656, aggJoin2199813788959086490, aggView9180930289715496097, aggJoin1067414819359532036, aggView3674393073357760174, aggJoin2722772214147057024;
