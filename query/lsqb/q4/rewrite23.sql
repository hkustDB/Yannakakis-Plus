## AggReduce Phase: 

# AggReduce69
# 1. aggView
create or replace view aggView2112925055370527382 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin1534427245887627567 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2112925055370527382 where Comment_replyOf_Message.ParentMessageId=aggView2112925055370527382.v1;

# AggReduce70
# 1. aggView
create or replace view aggView6778822349582296274 as select v1, SUM(annot) as annot from aggJoin1534427245887627567 group by v1;
# 2. aggJoin
create or replace view aggJoin895726496228619684 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6778822349582296274 where Message_hasTag_Tag.MessageId=aggView6778822349582296274.v1;

# AggReduce71
# 1. aggView
create or replace view aggView5723129243835516127 as select v1, SUM(annot) as annot from aggJoin895726496228619684 group by v1;
# 2. aggJoin
create or replace view aggJoin2992127211665307226 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5723129243835516127 where Message_hasCreator_Person.MessageId=aggView5723129243835516127.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2992127211665307226;

# drop view aggView2112925055370527382, aggJoin1534427245887627567, aggView6778822349582296274, aggJoin895726496228619684, aggView5723129243835516127, aggJoin2992127211665307226;
