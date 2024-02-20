## AggReduce Phase: 

# AggReduce48
# 1. aggView
create or replace view aggView8082295400427054178 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin7908861786325998452 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8082295400427054178 where Comment_replyOf_Message.ParentMessageId=aggView8082295400427054178.v1;

# AggReduce49
# 1. aggView
create or replace view aggView940220613188488938 as select v1, SUM(annot) as annot from aggJoin7908861786325998452 group by v1;
# 2. aggJoin
create or replace view aggJoin6539882260857843442 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView940220613188488938 where Message_hasTag_Tag.MessageId=aggView940220613188488938.v1;

# AggReduce50
# 1. aggView
create or replace view aggView6243349783712156839 as select v1, SUM(annot) as annot from aggJoin6539882260857843442 group by v1;
# 2. aggJoin
create or replace view aggJoin3076564396040436802 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6243349783712156839 where Message_hasCreator_Person.MessageId=aggView6243349783712156839.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3076564396040436802;

# drop view aggView8082295400427054178, aggJoin7908861786325998452, aggView940220613188488938, aggJoin6539882260857843442, aggView6243349783712156839, aggJoin3076564396040436802;
