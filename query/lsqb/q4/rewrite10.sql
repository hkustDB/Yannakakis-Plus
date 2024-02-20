## AggReduce Phase: 

# AggReduce30
# 1. aggView
create or replace view aggView2107223972491691422 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2072731441375763186 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2107223972491691422 where Message_hasCreator_Person.MessageId=aggView2107223972491691422.v1;

# AggReduce31
# 1. aggView
create or replace view aggView123827075955537617 as select v1, SUM(annot) as annot from aggJoin2072731441375763186 group by v1;
# 2. aggJoin
create or replace view aggJoin1555850020943047909 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView123827075955537617 where Message_hasTag_Tag.MessageId=aggView123827075955537617.v1;

# AggReduce32
# 1. aggView
create or replace view aggView1763385819604992135 as select v1, SUM(annot) as annot from aggJoin1555850020943047909 group by v1;
# 2. aggJoin
create or replace view aggJoin8065613615985726788 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1763385819604992135 where Comment_replyOf_Message.ParentMessageId=aggView1763385819604992135.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8065613615985726788;

# drop view aggView2107223972491691422, aggJoin2072731441375763186, aggView123827075955537617, aggJoin1555850020943047909, aggView1763385819604992135, aggJoin8065613615985726788;
